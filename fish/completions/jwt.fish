# Print an optspec for argparse to handle cmd's options that are independent of any subcommand.
function __fish_jwt_global_optspecs
	string join \n h/help V/version
end

function __fish_jwt_needs_command
	# Figure out if the current invocation already has a command.
	set -l cmd (commandline -opc)
	set -e cmd[1]
	argparse -s (__fish_jwt_global_optspecs) -- $cmd 2>/dev/null
	or return
	if set -q argv[1]
		# Also print the command, so this can be used to figure out what it is.
		echo $argv[1]
		return 1
	end
	return 0
end

function __fish_jwt_using_subcommand
	set -l cmd (__fish_jwt_needs_command)
	test -z "$cmd"
	and return 1
	contains -- $cmd[1] $argv
end

complete -c jwt -n "__fish_jwt_needs_command" -s h -l help -d 'Print help'
complete -c jwt -n "__fish_jwt_needs_command" -s V -l version -d 'Print version'
complete -c jwt -n "__fish_jwt_needs_command" -f -a "encode" -d 'Encode new JWTs'
complete -c jwt -n "__fish_jwt_needs_command" -f -a "decode" -d 'Decode a JWT'
complete -c jwt -n "__fish_jwt_needs_command" -f -a "completion" -d 'Print completion'
complete -c jwt -n "__fish_jwt_needs_command" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c jwt -n "__fish_jwt_using_subcommand encode" -s A -l alg -d 'the algorithm to use for signing the JWT' -r -f -a "{HS256\t'',HS384\t'',HS512\t'',RS256\t'',RS384\t'',RS512\t'',PS256\t'',PS384\t'',PS512\t'',ES256\t'',ES384\t'',EDDSA\t''}"
complete -c jwt -n "__fish_jwt_using_subcommand encode" -s k -l kid -d 'the kid to place in the header' -r
complete -c jwt -n "__fish_jwt_using_subcommand encode" -s t -l typ -d 'the type of token being encoded' -r -f -a "{jwt\t''}"
complete -c jwt -n "__fish_jwt_using_subcommand encode" -s P -l payload -d 'a key=value pair to add to the payload' -r
complete -c jwt -n "__fish_jwt_using_subcommand encode" -s e -l exp -d 'the time the token should expire, in seconds or a systemd.time string' -r
complete -c jwt -n "__fish_jwt_using_subcommand encode" -s i -l iss -d 'the issuer of the token' -r
complete -c jwt -n "__fish_jwt_using_subcommand encode" -s s -l sub -d 'the subject of the token' -r
complete -c jwt -n "__fish_jwt_using_subcommand encode" -s a -l aud -d 'the audience of the token' -r
complete -c jwt -n "__fish_jwt_using_subcommand encode" -l jti -d 'the jwt id of the token' -r
complete -c jwt -n "__fish_jwt_using_subcommand encode" -s n -l nbf -d 'the time the JWT should become valid, in seconds or a systemd.time string' -r
complete -c jwt -n "__fish_jwt_using_subcommand encode" -s S -l secret -d 'the secret to sign the JWT with. Prefix with @ to read from a file or b64: to use base-64 encoded bytes' -r
complete -c jwt -n "__fish_jwt_using_subcommand encode" -s o -l out -d 'The path of the file to write the result to (suppresses default standard output)' -r -F
complete -c jwt -n "__fish_jwt_using_subcommand encode" -l no-iat -d 'prevent an iat claim from being automatically added'
complete -c jwt -n "__fish_jwt_using_subcommand encode" -l no-typ -d 'prevent typ from being added to the header'
complete -c jwt -n "__fish_jwt_using_subcommand encode" -l keep-payload-order -d 'prevent re-ordering of payload keys'
complete -c jwt -n "__fish_jwt_using_subcommand encode" -s h -l help -d 'Print help'
complete -c jwt -n "__fish_jwt_using_subcommand encode" -s V -l version -d 'Print version'
complete -c jwt -n "__fish_jwt_using_subcommand decode" -s A -l alg -d 'The algorithm used to sign the JWT' -r -f -a "{HS256\t'',HS384\t'',HS512\t'',RS256\t'',RS384\t'',RS512\t'',PS256\t'',PS384\t'',PS512\t'',ES256\t'',ES384\t'',EDDSA\t''}"
complete -c jwt -n "__fish_jwt_using_subcommand decode" -l date -d 'Display unix timestamps as ISO 8601 dates [default: UTC] [possible values: UTC, Local, Offset (e.g. -02:00)]' -r
complete -c jwt -n "__fish_jwt_using_subcommand decode" -s S -l secret -d 'The secret to validate the JWT with. Prefix with @ to read from a file or b64: to use base-64 encoded bytes' -r
complete -c jwt -n "__fish_jwt_using_subcommand decode" -s o -l out -d 'The path of the file to write the result to (suppresses default standard output, implies JSON format)' -r -F
complete -c jwt -n "__fish_jwt_using_subcommand decode" -s j -l json -d 'Render the decoded JWT as JSON'
complete -c jwt -n "__fish_jwt_using_subcommand decode" -l ignore-exp -d 'Ignore token expiration date (`exp` claim) during validation'
complete -c jwt -n "__fish_jwt_using_subcommand decode" -s h -l help -d 'Print help'
complete -c jwt -n "__fish_jwt_using_subcommand decode" -s V -l version -d 'Print version'
complete -c jwt -n "__fish_jwt_using_subcommand completion" -s h -l help -d 'Print help'
complete -c jwt -n "__fish_jwt_using_subcommand completion" -s V -l version -d 'Print version'
complete -c jwt -n "__fish_jwt_using_subcommand help; and not __fish_seen_subcommand_from encode decode completion help" -f -a "encode" -d 'Encode new JWTs'
complete -c jwt -n "__fish_jwt_using_subcommand help; and not __fish_seen_subcommand_from encode decode completion help" -f -a "decode" -d 'Decode a JWT'
complete -c jwt -n "__fish_jwt_using_subcommand help; and not __fish_seen_subcommand_from encode decode completion help" -f -a "completion" -d 'Print completion'
complete -c jwt -n "__fish_jwt_using_subcommand help; and not __fish_seen_subcommand_from encode decode completion help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
