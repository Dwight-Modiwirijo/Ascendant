def main : IO Unit := do
  IO.println "✅ Test start"
  let x := 44
  let msg := s!"De waarde van x is: {x}"
  IO.println msg
