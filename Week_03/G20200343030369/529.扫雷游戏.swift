/*
 * @lc app=leetcode.cn id=529 lang=golang
 *
 * [529] 扫雷游戏
 *
 * https://leetcode-cn.com/problems/minesweeper/description/
 *
 * algorithms
 * Medium (58.74%)
 * Likes:    49
 * Dislikes: 0
 * Total Accepted:    4.4K
 * Total Submissions: 7.4K
 * Testcase Example:  '[["E","E","E","E","E"],["E","E","M","E","E"],["E","E","E","E","E"],["E","E","E","E","E"]]\n[3,0]'
 *
 * 让我们一起来玩扫雷游戏！
 * 
 * 给定一个代表游戏板的二维字符矩阵。 'M' 代表一个未挖出的地雷，'E' 代表一个未挖出的空方块，'B'
 * 代表没有相邻（上，下，左，右，和所有4个对角线）地雷的已挖出的空白方块，数字（'1' 到 '8'）表示有多少地雷与这块已挖出的方块相邻，'X'
 * 则表示一个已挖出的地雷。
 * 
 * 现在给出在所有未挖出的方块中（'M'或者'E'）的下一个点击位置（行和列索引），根据以下规则，返回相应位置被点击后对应的面板：
 * 
 * 
 * 如果一个地雷（'M'）被挖出，游戏就结束了- 把它改为 'X'。
 * 如果一个没有相邻地雷的空方块（'E'）被挖出，修改它为（'B'），并且所有和其相邻的方块都应该被递归地揭露。
 * 如果一个至少与一个地雷相邻的空方块（'E'）被挖出，修改它为数字（'1'到'8'），表示相邻地雷的数量。
 * 如果在此次点击中，若无更多方块可被揭露，则返回面板。
 * 
 * 
 * 
 * 
 * 示例 1：
 * 
 * 输入: 
 * 
 * [['E', 'E', 'E', 'E', 'E'],
 * ⁠['E', 'E', 'M', 'E', 'E'],
 * ⁠['E', 'E', 'E', 'E', 'E'],
 * ⁠['E', 'E', 'E', 'E', 'E']]
 * 
 * Click : [3,0]
 * 
 * 输出: 
 * 
 * [['B', '1', 'E', '1', 'B'],
 * ⁠['B', '1', 'M', '1', 'B'],
 * ⁠['B', '1', '1', '1', 'B'],
 * ⁠['B', 'B', 'B', 'B', 'B']]
 * 
 * 解释:
 * 
 * 
 * 
 * 示例 2：
 * 
 * 输入: 
 * 
 * [['B', '1', 'E', '1', 'B'],
 * ⁠['B', '1', 'M', '1', 'B'],
 * ⁠['B', '1', '1', '1', 'B'],
 * ⁠['B', 'B', 'B', 'B', 'B']]
 * 
 * Click : [1,2]
 * 
 * 输出: 
 * 
 * [['B', '1', 'E', '1', 'B'],
 * ⁠['B', '1', 'X', '1', 'B'],
 * ⁠['B', '1', '1', '1', 'B'],
 * ⁠['B', 'B', 'B', 'B', 'B']]
 * 
 * 解释:
 * 
 * 
 * 
 * 
 * 
 * 注意：
 * 
 * 
 * 输入矩阵的宽和高的范围为 [1,50]。
 * 点击的位置只能是未被挖出的方块 ('M' 或者 'E')，这也意味着面板至少包含一个可点击的方块。
 * 输入面板不会是游戏结束的状态（即有地雷已被挖出）。
 * 简单起见，未提及的规则在这个问题中可被忽略。例如，当游戏结束时你不需要挖出所有地雷，考虑所有你可能赢得游戏或标记方块的情况。
 * 
 */

// @lc code=start
class Solution {
    func updateBoard(_ board: [[Character]], _ click: [Int]) -> [[Character]] {
        
    }

    func updateBoard0(_ board: [[Character]], _ click: [Int]) -> [[Character]] {
      var board = board
      let (i, j) = (click[0], click[1])
      if board[i][j] == "M" {
        board[i][j] = "X"
        return board
      }

      var queue = [(Int, Int)]()
      queue.append((i, j))
      while !queue.isEmpty {
        let (i, j) = queue.removeFirst()
        var numAdjMines = 0
        var tmp = [(Int, Int)]()
        for (ai, aj) in adjs(i, j, board) {
          if board[ai][aj] == "M" {numAdjMines += 1}
          if board[ai][aj] == "E" {tmp.append((ai, aj))}
        }
        if numAdjMines != 0 {
          board[i][j] = Character("\(numAdjMines)")
        } else {
          board[i][j] = "B"
          queue.append(contentsOf: tmp)
        }
      }

      return board
    }

    func adjs(_ i: Int, _ j: Int, _ board: [[Character]]) -> [(Int, Int)] {
        var adjs = [(Int, Int)]()
        let n = board.count, m = board[0].count
        if i - 1 >= 0 && j - 1 >= 0 {adjs.append((i-1, j-1))}
        if i - 1 >= 0 {adjs.append((i-1, j))}
        if i - 1 >= 0 && j + 1 < m {adjs.append((i-1, j+1))}
        if j - 1 >= 0 {adjs.append((i, j-1))}
        if j + 1 < m {adjs.append((i, j+1))}
        if i + 1 < n && j - 1 >= 0 {adjs.append((i+1, j-1))}
        if i + 1 < n {adjs.append((i+1, j))}
        if i + 1 < n && j + 1 < m {adjs.append((i+1, j+1))}
        return adjs
    }

    // DFS
    func updateBoard1(_ board: [[Character]], _ click: [Int]) -> [[Character]] {
      var board = board
      let (i, j) = (click[0], click[1])
      if board[i][j] == "M" {
        board[i][j] = "X"
        return board
      }

      let dirs = [(-1, -1), (-1, 0), (-1, 1), (0, -1), (0, 1), (1, -1), (1, 0), (1, 1)]
      func dfs(_ i: Int, _ j: Int) {
        if board[i][j] == "M" || board[i][j] == "X" {return}

      }

      return board
    }
}
// @lc code=end

