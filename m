Message-ID: <4FA24D39.7050308@...1114...>
Date: Thu, 03 May 2012 11:17:45 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1335981252-7390-1-git-send-email-davids@...1347...>
	<CAOazyz2_BbFgKYPJkyKNVTuwYo-DdbJp__NZGqs_8Ckym36hVw@...278...>
In-Reply-To: <CAOazyz2_BbFgKYPJkyKNVTuwYo-DdbJp__NZGqs_8Ckym36hVw@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Simplify check_cmd_access() function
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 02/05/12 20:16, Alon Bar-Lev wrote:
> Looks good. If you testing this one, please ensure symbolic links 
> also works properly... :)

Just to confirm, as I forgot to mention that in the 'applied' message
earlier on.  This was tested with symlinks on Linux.  Both with a
symlink pointing to a non-existing file and to a file which does
exist.  It all behaved as expected - wrong symlink gave a "no such
file" error, otherwise the proper script was executed.


kind regards,

David Sommerseth



> On Wed, May 2, 2012 at 8:54 PM, David Sommerseth 
> <davids@...1347...> wrote:
>> To avoid confusion between check_file_access() and 
>> check_cmd_access() in the future, remove unneeded arguments from 
>> check_cmd_access()
>> 
>> As a command will always be a file, it should always check for 
>> CHKACC_FILE and nothing else.  And as the commands always will 
>> need X_OK, check only for that.
>> 
>> One change from earlier behaviour is that R_OK is not checked 
>> for.  The reason is that only scripts require R_OK to work. 
>> However, a system might be installed with binaries with only
>> X_OK set.  If a script is missing R_OK, then the execution will
>> fail due to lacking permissions.
>> 
>> Signed-off-by: David Sommerseth <davids@...1347...> --- 
>> src/openvpn/options.c |   48 
>> ++++++++++++++++++++++++++---------------------- 1 files
>> changed, 26 insertions(+), 22 deletions(-)
>> 
>> diff --git a/src/openvpn/options.c b/src/openvpn/options.c index 
>> 5da2eb6..7769625 100644 --- a/src/openvpn/options.c +++ 
>> b/src/openvpn/options.c @@ -2690,7 +2690,7 @@ 
>> check_file_access(const int type, const char *file, const int 
>> mode, const char * * check_file_access() arguments. */ static 
>> bool -check_cmd_access(const int type, const char *command,
>> const int mode, const char *opt) +check_cmd_access(const char
>> *command, const char *opt) { struct argv argv; bool return_code;
>> @@ -2705,7 +2705,11 @@ check_cmd_access(const int type, const
>> char *command, const int mode, const char
>> 
>> /* if an executable is specified then check it; otherwise, 
>> complain */ if (argv.argv[0]) -      return_code = 
>> check_file_access(type, argv.argv[0], mode, opt); +    /*
>> Scripts requires R_OK as well, but that might fail on binaries
>> which + * only requires X_OK to function on Unix - a scenario
>> not unlikely to +     * be seen on suid binaries. +     */ + 
>> return_code = check_file_access(CHKACC_FILE, argv.argv[0], X_OK, 
>> opt); else { msg (M_NOPREFIX|M_OPTERR, "%s fails with '%s': No 
>> path to executable.", @@ -2797,26 +2801,26 @@ 
>> options_postprocess_filechecks (struct options *options)
>> 
>> /* ** Script hooks that accept an optionally quoted and/or 
>> escaped executable path, ** */ /* ** optionally followed by 
>> arguments ** */ -  errs |= check_cmd_access (CHKACC_FILE, 
>> options->auth_user_pass_verify_script, - R_OK|X_OK,
>> "--auth-user-pass-verify script"); -  errs |= check_cmd_access
>> (CHKACC_FILE, options->client_connect_script, - R_OK|X_OK,
>> "--client-connect script"); -  errs |= check_cmd_access
>> (CHKACC_FILE, options->client_disconnect_script, - R_OK|X_OK,
>> "--client-disconnect script"); -  errs |= check_cmd_access
>> (CHKACC_FILE, options->tls_verify, - R_OK|X_OK, "--tls-verify
>> script"); -  errs |= check_cmd_access (CHKACC_FILE,
>> options->up_script, - R_OK|X_OK, "--up script"); -  errs |=
>> check_cmd_access (CHKACC_FILE, options->down_script, - R_OK|X_OK,
>> "--down script"); -  errs |= check_cmd_access (CHKACC_FILE,
>> options->ipchange, - R_OK|X_OK, "--ipchange script"); -  errs |=
>> check_cmd_access (CHKACC_FILE, options->route_script, - 
>> R_OK|X_OK, "--route-up script"); -  errs |= check_cmd_access 
>> (CHKACC_FILE, options->route_predown_script, - R_OK|X_OK,
>> "--route-pre-down script"); -  errs |= check_cmd_access
>> (CHKACC_FILE, options->learn_address_script, - R_OK|X_OK,
>> "--learn-address script"); +  errs |= check_cmd_access 
>> (options->auth_user_pass_verify_script, + 
>> "--auth-user-pass-verify script"); +  errs |= check_cmd_access 
>> (options->client_connect_script, + "--client-connect script"); +
>> errs |= check_cmd_access (options->client_disconnect_script, + 
>> "--client-disconnect script"); +  errs |= check_cmd_access 
>> (options->tls_verify, +                            "--tls-verify 
>> script"); +  errs |= check_cmd_access (options->up_script, + 
>> "--up script"); +  errs |= check_cmd_access 
>> (options->down_script, +                            "--down 
>> script"); +  errs |= check_cmd_access (options->ipchange, + 
>> "--ipchange script"); +  errs |= check_cmd_access 
>> (options->route_script, +                            "--route-up 
>> script"); +  errs |= check_cmd_access 
>> (options->route_predown_script, + "--route-pre-down script"); +
>> errs |= check_cmd_access (options->learn_address_script, + 
>> "--learn-address script"); #endif /* P2MP_SERVER */
>> 
>> if (errs) -- 1.7.4.4
>> 
>> 
>> ------------------------------------------------------------------------------
>>
>>
>> 
Live Security Virtual Conference
>> Exclusive live event will cover all the ways today's security and
>> threat landscape has changed and how IT managers can respond. 
>> Discussions will include endpoint security, mobile security and 
>> the latest in malware threats. 
>> http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/ 
>> _______________________________________________ Openvpn-devel 
>> mailing list Openvpn-devel@lists.sourceforge.net 
>> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
> 
> ------------------------------------------------------------------------------
>
>
> 
Live Security Virtual Conference
> Exclusive live event will cover all the ways today's security and 
> threat landscape has changed and how IT managers can respond. 
> Discussions will include endpoint security, mobile security and
> the latest in malware threats. 
> http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/ 
> _______________________________________________ Openvpn-devel 
> mailing list Openvpn-devel@lists.sourceforge.net 
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
> 

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk+iTTcACgkQDC186MBRfrrHowCePfFeXrX1XrvZ1kgWHyHxeUn/
6n0Ani5Wc4jzQYPq68VswxbeN3LPBBfY
=GQ81
-----END PGP SIGNATURE-----

