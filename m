MIME-Version: 1.0
Message-ID: <trinity-991a1d45-4a26-48b4-b7b3-d50c17a111df-1380980922550@...1842...>
From: Max.Muster@...1832...
Date: Sat, 5 Oct 2013 15:48:42 +0200 (CEST)
In-Reply-To: <0MVuuM-1VL5oS2YOm-00X7Ks@...1825...>
References: <0MAQ0o-1VYfA02dyM-00BYQL@...1825...>,
	<0MVuuM-1VL5oS2YOm-00X7Ks@...1825...>
Subject: Re: [Openvpn-devel] [PATCH] Allow inlining of --auth-user-pass
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: Davide Brini <dave_br@...1278...>
Cc: openvpn-devel@lists.sourceforge.net

<html><head></head><body><div style="font-family: Verdana;font-size: 12.0px;"><div>
<div>Hi Davide,</div>

<div>&nbsp;</div>

<div>nice idea. But I think I found two small bugs:</div>

<div>First, it won&#39;t compile in a config w/o ENABLE_CLIENT_CR defined (there is no &quot;sc_info&quot;).<br/>
Second, if I&#39;m not mistaken, name and password are not copied correctly:<br/>
If # of charachters is (pos - prev), the last charakter is at [pos - prev -1] and to terminate the string you should set [pos - prev] to &#39;&#92;0&#39;.</div>

<div>&nbsp;</div>

<div>My suggestion (not sure, if the first one works with management enabled, only tested w/o).</div>

<div>&nbsp;</div>

<div>&nbsp;</div>

<div>Fix in src/openvpn/misc.c (add #ifdef):<br/>
[...]<br/>
+<br/>
+&nbsp; if ( ( !streq(options-&gt;auth_user_pass_file, &quot;stdin&quot;) &#124;&#124; options-&gt;auth_user_pass_file_inline) &amp;&amp; options-&gt;auth_nocache)<br/>
+&nbsp;&nbsp;&nbsp; msg (M_USAGE, &quot;Cannot use --auth-nocache with credentials from file&quot;);<br/>
+<br/>
+#ifdef ENABLE_CLIENT_CR<br/>
+&nbsp; if ( ( !streq(options-&gt;auth_user_pass_file, &quot;stdin&quot;) &#124;&#124; options-&gt;auth_user_pass_file_inline) &amp;&amp; options-&gt;sc_info.challenge_text)<br/>
+&nbsp;&nbsp;&nbsp; msg (M_USAGE, &quot;Credentials cannot be in a file if using --static-challenge&quot;);<br/>
+#endif<br/>
+<br/>
+&nbsp; if (options-&gt;auth_user_pass_file_inline)<br/>
+&nbsp;&nbsp;&nbsp; {<br/>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int n_inlined = 0;<br/>
[...]</div>

<div>&nbsp;</div>

<div>&nbsp;</div>

<div>in src/openvpn/ssl.c yo should use [pos - prev] instead of [pos - prev +1]<br/>
[...]<br/>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {<br/>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; strncpy(inlined_username, prev, pos - prev);<br/>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; inlined_username[pos - prev] = &#39;&#92;0&#39;;<br/>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; msg (M_INFO, &quot;Using inlined username: %s (POS=%d PREV=%d)&quot;, inlined_username, pos, prev);<br/>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br/>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br/>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {<br/>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; strncpy(inlined_password, prev, pos - prev);<br/>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; inlined_password[pos - prev] = &#39;&#92;0&#39;;<br/>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; msg (M_INFO, &quot;Using inlined password: ...**%s**&quot;,inlined_password);<br/>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br/>
[...]</div>

<div><br/>
I hope it&#39;s o.k. just to give the idea but not post full patches again.</div>

<div><br/>
Regards</div>

<div>&nbsp;</div>

<div>Joerg<br/>
&nbsp;</div>

<div>&nbsp;</div>

<div>&nbsp;
<div name="quote" style="margin:10px 5px 5px 10px; padding: 10px 0 10px 10px; border-left:2px solid #C3D9E5; word-wrap: break-word; -webkit-nbsp-mode: space; -webkit-line-break: after-white-space;">
<div style="margin:0 0 10px 0;"><b>Gesendet:</b>&nbsp;Donnerstag, 03. Oktober 2013 um 10:30 Uhr<br/>
<b>Von:</b>&nbsp;&quot;Davide Brini&quot; &lt;dave_br@...1278...&gt;<br/>
<b>An:</b>&nbsp;openvpn-devel@lists.sourceforge.net<br/>
<b>Betreff:</b>&nbsp;Re: [Openvpn-devel] [PATCH] Allow inlining of --auth-user-pass</div>

<div name="quoted-content">(previous version contained a leftover debug line left by mistake, sorry)<br/>
<br/>
This patch allows inlining of the --auth-user-pass directive, so it is now<br/>
possible to do<br/>
<br/>
&lt;auth-user-pass&gt;<br/>
myusername<br/>
mypassword<br/>
&lt;/auth-user-pass&gt;<br/>
<br/>
or supply just the username, eg<br/>
<br/>
&lt;auth-user-pass&gt;<br/>
myusername<br/>
&lt;/auth-user-pass&gt;<br/>
<br/>
(in this case the user is prompted for the password only).<br/>
The most changed files are options.c (sanity check of inlined credentials)<br/>
and ssl.c (actual parsing of the inlined credentials).<br/>
<br/>
Udates to the documentation will be provided in a separate patch if and when<br/>
the present patch is accepted.<br/>
<br/>
As discussed on IRC, for the time being the non-inlined syntax<br/>
<br/>
auth-user-pass [up]<br/>
<br/>
is still supported and [up] is expected to contain username and password<br/>
on two lines.<br/>
<br/>
Signed-off-by: Davide Brini &lt;dave_br@...1278...&gt;<br/>
---<br/>
src/openvpn/init.c &#124; 6 +--<br/>
src/openvpn/misc.c &#124; 2 +-<br/>
src/openvpn/options.c &#124; 56 ++++++++++++++++++++++++----<br/>
src/openvpn/options.h &#124; 2 +<br/>
src/openvpn/ssl.c &#124; 98 +++++++++++++++++++++++++++++++++++++------------<br/>
src/openvpn/ssl.h &#124; 2 +-<br/>
6 files changed, 131 insertions(+), 35 deletions(-)<br/>
<br/>
diff --git a/src/openvpn/init.c b/src/openvpn/init.c<br/>
index 031fb20..b11ae8a 100644<br/>
--- a/src/openvpn/init.c<br/>
+++ b/src/openvpn/init.c<br/>
@@ -400,12 +400,12 @@ init_query_passwords (struct context *c)<br/>
<br/>
#if P2MP<br/>
/* Auth user/pass input */<br/>
- if (c-&gt;options.auth_user_pass_file)<br/>
+ if (c-&gt;options.auth_user_pass_file &#124;&#124; c-&gt;options.auth_user_pass_file_inline)<br/>
{<br/>
#ifdef ENABLE_CLIENT_CR<br/>
- auth_user_pass_setup (c-&gt;options.auth_user_pass_file, &amp;c-&gt;options.sc_info);<br/>
+ auth_user_pass_setup (c-&gt;options.auth_user_pass_file, c-&gt;options.auth_user_pass_file_inline, &amp;c-&gt;options.sc_info);<br/>
#else<br/>
- auth_user_pass_setup (c-&gt;options.auth_user_pass_file, NULL);<br/>
+ auth_user_pass_setup (c-&gt;options.auth_user_pass_file, c-&gt;options.auth_user_pass_file_inline, NULL);<br/>
#endif<br/>
}<br/>
#endif<br/>
diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c<br/>
index 4688444..05bc2f0 100644<br/>
--- a/src/openvpn/misc.c<br/>
+++ b/src/openvpn/misc.c<br/>
@@ -1036,7 +1036,7 @@ get_user_pass_cr (struct user_pass *up,<br/>
<br/>
if (!up-&gt;defined)<br/>
{<br/>
- const bool from_stdin = (!auth_file &#124;&#124; !strcmp (auth_file, &quot;stdin&quot;));<br/>
+ const bool from_stdin = (!auth_file &#124;&#124; streq (auth_file, &quot;stdin&quot;));<br/>
<br/>
if (flags &amp; GET_USER_PASS_PREVIOUS_CREDS_FAILED)<br/>
msg (M_WARN, &quot;Note: previous &#39;%s&#39; credentials failed&quot;, prefix);<br/>
diff --git a/src/openvpn/options.c b/src/openvpn/options.c<br/>
index 4d0271f..6f2ea66 100644<br/>
--- a/src/openvpn/options.c<br/>
+++ b/src/openvpn/options.c<br/>
@@ -1233,6 +1233,7 @@ show_p2mp_parms (const struct options *o)<br/>
SHOW_BOOL (client);<br/>
SHOW_BOOL (pull);<br/>
SHOW_STR (auth_user_pass_file);<br/>
+ SHOW_STR (auth_user_pass_file_inline);<br/>
<br/>
gc_free (&amp;gc);<br/>
}<br/>
@@ -2080,7 +2081,7 @@ options_postprocess_verify_ce (const struct options *options, const struct conne<br/>
if (options-&gt;ifconfig_ipv6_local &amp;&amp; !options-&gt;tun_ipv6 )<br/>
msg (M_INFO, &quot;Warning: --ifconfig-ipv6 without --tun-ipv6 will not do IPv6&quot;);<br/>
<br/>
- if (options-&gt;auth_user_pass_file)<br/>
+ if ( options-&gt;auth_user_pass_file &#124;&#124; options-&gt;auth_user_pass_file_inline )<br/>
msg (M_USAGE, &quot;--auth-user-pass cannot be used with --mode server (it should be used on the client side only)&quot;);<br/>
if (options-&gt;ccd_exclusive &amp;&amp; !options-&gt;client_config_dir)<br/>
msg (M_USAGE, &quot;--ccd-exclusive must be used with --client-config-dir&quot;);<br/>
@@ -2274,7 +2275,7 @@ options_postprocess_verify_ce (const struct options *options, const struct conne<br/>
if (sum == 0)<br/>
{<br/>
#if P2MP<br/>
- if (!options-&gt;auth_user_pass_file)<br/>
+ if (!options-&gt;auth_user_pass_file &amp;&amp; !options-&gt;auth_user_pass_file_inline)<br/>
#endif<br/>
msg (M_USAGE, &quot;No client-side authentication method is specified. You must use either --cert/--key, --pkcs12, or --auth-user-pass&quot;);<br/>
}<br/>
@@ -2350,8 +2351,42 @@ options_postprocess_verify_ce (const struct options *options, const struct conne<br/>
#endif /* ENABLE_SSL */<br/>
<br/>
#if P2MP<br/>
- if (options-&gt;auth_user_pass_file &amp;&amp; !options-&gt;pull)<br/>
+ if ( ( options-&gt;auth_user_pass_file &#124;&#124; options-&gt;auth_user_pass_file_inline) &amp;&amp; !options-&gt;pull)<br/>
msg (M_USAGE, &quot;--auth-user-pass requires --pull&quot;);<br/>
+<br/>
+ if ( ( !streq(options-&gt;auth_user_pass_file, &quot;stdin&quot;) &#124;&#124; options-&gt;auth_user_pass_file_inline) &amp;&amp; options-&gt;auth_nocache)<br/>
+ msg (M_USAGE, &quot;Cannot use --auth-nocache with credentials from file&quot;);<br/>
+<br/>
+ if ( ( !streq(options-&gt;auth_user_pass_file, &quot;stdin&quot;) &#124;&#124; options-&gt;auth_user_pass_file_inline) &amp;&amp; options-&gt;sc_info.challenge_text)<br/>
+ msg (M_USAGE, &quot;Credentials cannot be in a file if using --static-challenge&quot;);<br/>
+<br/>
+ if (options-&gt;auth_user_pass_file_inline)<br/>
+ {<br/>
+ int n_inlined = 0;<br/>
+ const char *pos = options-&gt;auth_user_pass_file_inline;<br/>
+ const char *prev = pos;<br/>
+<br/>
+ if ( strlen(pos) == 0 )<br/>
+ msg (M_USAGE, &quot;Invalid format for inlined --auth-user-pass&quot;);<br/>
+<br/>
+ while( (pos = strchr(pos, &#39;&#92;n&#39;)) != NULL )<br/>
+ {<br/>
+ n_inlined++;<br/>
+<br/>
+ if (n_inlined &gt; 2)<br/>
+ msg (M_USAGE, &quot;Too many lines in inlined --auth-user-pass&quot;);<br/>
+<br/>
+ if ( pos - prev &gt; USER_PASS_LEN - 1 )<br/>
+ msg (M_USAGE, &quot;Line too long in inlined --auth-user-pass&quot;);<br/>
+<br/>
+ pos++;<br/>
+ prev = pos;<br/>
+ }<br/>
+<br/>
+ if ( (n_inlined == 0) &#124;&#124; (*prev != &#39;&#92;0&#39;) )<br/>
+ msg (M_USAGE, &quot;Invalid format for inlined --auth-user-pass&quot;);<br/>
+<br/>
+ }<br/>
#endif<br/>
<br/>
uninit_options (&amp;defaults);<br/>
@@ -2719,9 +2754,10 @@ options_postprocess_filechecks (struct options *options)<br/>
&quot;--management user/password file&quot;);<br/>
#endif /* ENABLE_MANAGEMENT */<br/>
#if P2MP<br/>
- errs &#124;= check_file_access (CHKACC_FILE&#124;CHKACC_ACPTSTDIN,<br/>
- options-&gt;auth_user_pass_file, R_OK,<br/>
- &quot;--auth-user-pass&quot;);<br/>
+ if (!streq(options-&gt;auth_user_pass_file, INLINE_FILE_TAG))<br/>
+ errs &#124;= check_file_access (CHKACC_FILE&#124;CHKACC_ACPTSTDIN,<br/>
+ options-&gt;auth_user_pass_file, R_OK,<br/>
+ &quot;--auth-user-pass&quot;);<br/>
#endif /* P2MP */<br/>
<br/>
/* ** System related ** */<br/>
@@ -5894,7 +5930,12 @@ add_option (struct options *options,<br/>
VERIFY_PERMISSION (OPT_P_GENERAL);<br/>
if (p[1])<br/>
{<br/>
- options-&gt;auth_user_pass_file = p[1];<br/>
+ options-&gt;auth_user_pass_file = p[1];<br/>
+ if (streq (p[1], INLINE_FILE_TAG) &amp;&amp; p[2])<br/>
+ {<br/>
+ options-&gt;auth_user_pass_file = &quot;stdin&quot;;<br/>
+ options-&gt;auth_user_pass_file_inline = p[2];<br/>
+ }<br/>
}<br/>
else<br/>
options-&gt;auth_user_pass_file = &quot;stdin&quot;;<br/>
@@ -6591,6 +6632,7 @@ add_option (struct options *options,<br/>
else if (streq (p[0], &quot;auth-nocache&quot;))<br/>
{<br/>
VERIFY_PERMISSION (OPT_P_GENERAL);<br/>
+ options-&gt;auth_nocache = true;<br/>
ssl_set_auth_nocache ();<br/>
}<br/>
else if (streq (p[0], &quot;auth-token&quot;) &amp;&amp; p[1])<br/>
diff --git a/src/openvpn/options.h b/src/openvpn/options.h<br/>
index 8e0e367..5ae733a 100644<br/>
--- a/src/openvpn/options.h<br/>
+++ b/src/openvpn/options.h<br/>
@@ -292,6 +292,7 @@ struct options<br/>
bool up_delay;<br/>
bool up_restart;<br/>
bool daemon;<br/>
+ bool auth_nocache;<br/>
<br/>
int remap_sigusr1;<br/>
<br/>
@@ -460,6 +461,7 @@ struct options<br/>
bool pull; /* client pull of config options from server */<br/>
int push_continuation;<br/>
const char *auth_user_pass_file;<br/>
+ const char *auth_user_pass_file_inline;<br/>
struct options_pre_pull *pre_pull;<br/>
<br/>
int server_poll_timeout;<br/>
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c<br/>
index 69f77f3..aa249f1 100644<br/>
--- a/src/openvpn/ssl.c<br/>
+++ b/src/openvpn/ssl.c<br/>
@@ -354,36 +354,88 @@ static char *auth_challenge; /* GLOBAL */<br/>
#endif<br/>
<br/>
void<br/>
-auth_user_pass_setup (const char *auth_file, const struct static_challenge_info *sci)<br/>
+auth_user_pass_setup (const char *auth_file, const char *auth_file_inline, const struct static_challenge_info *sci)<br/>
{<br/>
+<br/>
+ int extra_flags = 0;<br/>
+ int n_inlined = 0;<br/>
+ char inlined_username[USER_PASS_LEN];<br/>
+ char inlined_password[USER_PASS_LEN];<br/>
+<br/>
auth_user_pass_enabled = true;<br/>
+<br/>
if (!auth_user_pass.defined)<br/>
{<br/>
+ if (auth_file &amp;&amp; streq (auth_file, &quot;stdin&quot;) &amp;&amp; auth_file_inline)<br/>
+ {<br/>
+ /* check how much is inlined. */<br/>
+ const char *pos = auth_file_inline;<br/>
+ const char *prev = pos;<br/>
+<br/>
+ while( (pos = strchr(pos, &#39;&#92;n&#39;)) != NULL)<br/>
+ {<br/>
+ n_inlined++;<br/>
+<br/>
+ if (n_inlined == 1)<br/>
+ {<br/>
+ strncpy(inlined_username, prev, pos - prev);<br/>
+ inlined_username[pos - prev + 1] = &#39;&#92;0&#39;;<br/>
+ msg (M_INFO, &quot;Using inlined username: %s&quot;, inlined_username);<br/>
+ }<br/>
+ else<br/>
+ {<br/>
+ strncpy(inlined_password, prev, pos - prev);<br/>
+ inlined_password[pos - prev + 1] = &#39;&#92;0&#39;;<br/>
+ msg (M_INFO, &quot;Using inlined password: ...&quot;);<br/>
+ }<br/>
+<br/>
+ pos++;<br/>
+ prev = pos;<br/>
+ }<br/>
+<br/>
+ if (n_inlined == 1)<br/>
+ extra_flags = GET_USER_PASS_PASSWORD_ONLY;<br/>
+ }<br/>
+<br/>
+ if (n_inlined == 2)<br/>
+ {<br/>
+ strcpy(auth_user_pass.username, inlined_username);<br/>
+ strcpy(auth_user_pass.password, inlined_password);<br/>
+ auth_user_pass.defined = true;<br/>
+ }<br/>
+ else<br/>
+ {<br/>
#if AUTO_USERID<br/>
- get_user_pass_auto_userid (&amp;auth_user_pass, auth_file);<br/>
+ get_user_pass_auto_userid (&amp;auth_user_pass, auth_file);<br/>
#else<br/>
# ifdef ENABLE_CLIENT_CR<br/>
- if (auth_challenge) /* dynamic challenge/response */<br/>
- get_user_pass_cr (&amp;auth_user_pass,<br/>
- auth_file,<br/>
- UP_TYPE_AUTH,<br/>
- GET_USER_PASS_MANAGEMENT&#124;GET_USER_PASS_SENSITIVE&#124;GET_USER_PASS_DYNAMIC_CHALLENGE,<br/>
- auth_challenge);<br/>
- else if (sci) /* static challenge response */<br/>
- {<br/>
- int flags = GET_USER_PASS_MANAGEMENT&#124;GET_USER_PASS_SENSITIVE&#124;GET_USER_PASS_STATIC_CHALLENGE;<br/>
- if (sci-&gt;flags &amp; SC_ECHO)<br/>
- flags &#124;= GET_USER_PASS_STATIC_CHALLENGE_ECHO;<br/>
- get_user_pass_cr (&amp;auth_user_pass,<br/>
- auth_file,<br/>
- UP_TYPE_AUTH,<br/>
- flags,<br/>
- sci-&gt;challenge_text);<br/>
- }<br/>
- else<br/>
+ if (auth_challenge) /* dynamic challenge/response */<br/>
+ get_user_pass_cr (&amp;auth_user_pass,<br/>
+ auth_file,<br/>
+ UP_TYPE_AUTH,<br/>
+ GET_USER_PASS_MANAGEMENT&#124;GET_USER_PASS_SENSITIVE&#124;GET_USER_PASS_DYNAMIC_CHALLENGE&#124;extra_flags,<br/>
+ auth_challenge);<br/>
+ else if (sci) /* static challenge response */<br/>
+ {<br/>
+ int flags = GET_USER_PASS_MANAGEMENT&#124;GET_USER_PASS_SENSITIVE&#124;GET_USER_PASS_STATIC_CHALLENGE&#124;extra_flags;<br/>
+ if (sci-&gt;flags &amp; SC_ECHO)<br/>
+ flags &#124;= GET_USER_PASS_STATIC_CHALLENGE_ECHO;<br/>
+<br/>
+ get_user_pass_cr (&amp;auth_user_pass,<br/>
+ auth_file,<br/>
+ UP_TYPE_AUTH,<br/>
+ flags,<br/>
+ sci-&gt;challenge_text);<br/>
+ }<br/>
+ else<br/>
# endif<br/>
- get_user_pass (&amp;auth_user_pass, auth_file, UP_TYPE_AUTH, GET_USER_PASS_MANAGEMENT&#124;GET_USER_PASS_SENSITIVE);<br/>
+ get_user_pass (&amp;auth_user_pass, auth_file, UP_TYPE_AUTH, GET_USER_PASS_MANAGEMENT&#124;GET_USER_PASS_SENSITIVE&#124;extra_flags);<br/>
#endif<br/>
+ }<br/>
+<br/>
+ if (n_inlined == 1)<br/>
+ strcpy(auth_user_pass.username, inlined_username);<br/>
+<br/>
}<br/>
}<br/>
<br/>
@@ -1892,9 +1944,9 @@ key_method_2_write (struct buffer *buf, struct tls_session *session)<br/>
if (auth_user_pass_enabled)<br/>
{<br/>
#ifdef ENABLE_CLIENT_CR<br/>
- auth_user_pass_setup (NULL, session-&gt;opt-&gt;sci);<br/>
+ auth_user_pass_setup (NULL, NULL, session-&gt;opt-&gt;sci);<br/>
#else<br/>
- auth_user_pass_setup (NULL, NULL);<br/>
+ auth_user_pass_setup (NULL, NULL, NULL);<br/>
#endif<br/>
if (!write_string (buf, auth_user_pass.username, -1))<br/>
goto error;<br/>
diff --git a/src/openvpn/ssl.h b/src/openvpn/ssl.h<br/>
index cd7cae2..c7554aa 100644<br/>
--- a/src/openvpn/ssl.h<br/>
+++ b/src/openvpn/ssl.h<br/>
@@ -388,7 +388,7 @@ void pem_password_setup (const char *auth_file);<br/>
* Setup authentication username and password. If auth_file is given, use the<br/>
* credentials stored in the file.<br/>
*/<br/>
-void auth_user_pass_setup (const char *auth_file, const struct static_challenge_info *sc_info);<br/>
+void auth_user_pass_setup (const char *auth_file, const char *auth_file_inline, const struct static_challenge_info *sc_info);<br/>
<br/>
/*<br/>
* Ensure that no caching is performed on authentication information<br/>
--<br/>
1.7.10.4------------------------------------------------------------------------------<br/>
October Webinars: Code for Performance<br/>
Free Intel webinars can help you accelerate application performance.<br/>
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from<br/>
the latest Intel processors and coprocessors. See abstracts and register &gt;<br/>
<a href="http://pubads.g.doubleclick.net/gampad/clk?id=60134791&amp;iu=/4140/ostg.clktrk_______________________________________________" target="_blank">http://pubads.g.doubleclick.net/gampad/clk?id=60134791&amp;iu=/4140/ostg.clktrk_______________________________________________</a><br/>
Openvpn-devel mailing list<br/>
Openvpn-devel@lists.sourceforge.net<br/>
<a href="https://lists.sourceforge.net/lists/listinfo/openvpn-devel" target="_blank">https://lists.sourceforge.net/lists/listinfo/openvpn-devel</a></div>
</div>
</div>
</div>

<div>&nbsp;</div>

<div class="signature">&nbsp;</div></div></body></html>

