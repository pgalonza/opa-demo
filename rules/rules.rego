package rules

import rego.v1

default allow = false

allow if {
	[_, payload, _] := io.jwt.decode(input.jwt)
	"admin" in payload.roles
}
