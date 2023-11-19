local ls = require("luasnip")
local s = ls.snippet
local c = ls.c
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep

return {
  s({
    trig = 'issue',
    desc = 'Case Notes'
  },
  fmt([[
  * {case_number}
    - {customer}
    - {desc}
    - ( ) {task}
  ]],
  {
    case_number = i(1, 'Case Number'),
    customer = i(2, 'Customer Name'),
    desc = i(3, 'Issue Description'),
    task = i(4, 'First Task')
  }
  )),
  s({
    trig = 'devops',
    desc = 'Dev Ops notes'
  },
  fmt([[
  * {ref}
    - {product}
    - {desc}
    - ( ) {task}
  ]],
  {
    ref = i(1, 'DevOps Reference'),
    product = c(2, {
      t('Access Recruit'),
      t('Access TeamSeer'),
      t('Access SafePay'),
      t('Access Workspace'),
      t('Access FinOps'),
      t('Access Engage'),
    }),
    desc = i(3, 'Issue Description'),
    task = i(4, 'First Task')
  } -- TODO: Autogenerate devops link from ref & product
  ))
}
