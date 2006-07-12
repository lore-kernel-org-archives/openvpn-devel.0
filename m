From: P Kern <pak@...698...>
Message-Id: <06Jul12.154422edt.35599@...699...>
Date: Wed, 12 Jul 2006 15:44:22 -0400
Subject: Re: [Openvpn-devel] Patch: allow browser as a management GUI
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: alon.barlev@...277...
Cc: openvpn-devel@lists.sourceforge.net, pak@...698...

From gmail.com!alon.barlev Tue Jul 11 15:20:35 2006
> P Kern wrote:
> > Just fyi - a patch (id 1520128) has been posted to Sourceforge
> > which allows a browser to connect to the management interface.
> > The patch is based on openvpn-2.1_beta14.
> > Since most platforms now have a web browser, this patch could
> > lessen the need for a separate OpenVPN management GUI.
> > Hope this patch proves useful.
> > Paul Kern, CNS, U Toronto.
> 
> Hello,
> 
> Nice idea!
> Just going through your patch...

Hello Alon.
Thanks for the quick feedback.

> I have some questions...
> 
> Can you please #ifdef all relevant additions, such as:
> 	HT_send_RAW(man);
> 	HT_now_reset

Sure, no problem.  Done.
The updated patch is available from ...
	http://cns.utoronto.ca/~pkern/ovpn-mgmt-http/

> I personally don't like multi lines strings... In stead of:
> f ("xxxxxx\n\
> yyyyy");
> Consider:
> f ("xxxxxx\n"
>    "yyyyyy\n");
> 

Yes, that is _MUCH_ cleaner. Thanks.
Done. See the updated patch.

> Also C concat is not so readable you not just writing HTML?
> 
>        len = openvpn_snprintf(ht_getpw, sizeof(ht_getpw),
> "<body onLoad=\"document.%s.%s.focus()\">\r\n\
> " MAN_self_form "\" name=\"%s\" method=\"post\">\r\n\
> " HTML_HIDE_POST "password\"> [%s] Password: \
> " HTML_GETPWD "%s\">\r\n " HTML_SUBMIT "\r\n",
>                 form, type, form, type, type);
> 
> -> Something like:
> 	I think that when the whole form is written it is much more easy to understand what it does.
> 
> 	len = openvpn_sprintf (ht_getpw, sizeof (ht_getpw),
> 		(
> 			"<html>"
> 			"<body onload=\"document.prompt.pwd.focus()\">"
> 				"<form name=\"prompt\" method=\"post\">"
> 					"<input type=\"hidden\" name=\"%s\">"
> 					"<p>[%s] Password: <input type=\"password\"></p>"
> 					"<input type=\"submit\" value=\"Submit\"> <input type=\"button\" value=\"cancel\">"
> 				"</form>"
> 			"</body>"
> 			"</html>"
> 		),
> 		type, type
> 	);


Using string macros was a coding choice.  I'm not very well-versed in
HTML (in hindsight, I probably should have used a standalone C library
like libhtmlparse or something).  String macros meant that common HTML
fragments could be recycled without having to re-enter each bit.  Any
changes could be made just once, instead of in many places.  And the
macros helped keep the raw HTML parts readable (for me, at least :-).

> Cancel should be completed... So that both button will submit with
> hidden action field to be ok or cancel.

Sorry.  I'm not clear on what the {Cancel} button is supposed to do
(again, I'm not well-versed in HTML so bear with me).

> Next stage is to move all these strings into external files... So they
> can be modified without the need of recompilation... I am thinking about
> translation and such. There can be an  option to read these files...
> These files will be much easier to write since you don't have to escape
> quotes :)

If I understand what you mean, that's the reason for the 2nd config option
(management-http-home). It allows a custom external web page to be used
instead of relying on the hardcoded, builtin default "home page".

> Also, it is better to have variables in a $0...$N format so that the order
> may be modified for different languages. Better is to insert variables
> as ${var}... And if you want to go standard, you can parse <%=var%> :)

Ummm, okay.  This goes beyond my limited knowledge of HTML.
If someone wants to pick this up and run with it, please feel free.
Otherwise, I'll need some "handholding" in the form of pointers to
HTML docs (guides, references, examples, tutorials, etc, etc.)

> Why did you change:
>         if (parms[0] && streq (parms[0], "password"))
> -       msg (D_MANAGEMENT_DEBUG, "MANAGEMENT: CMD 'password [...]'");
> +       msg (D_MANAGEMENT_DEBUG, "MANAGEMENT: GET 'password [...]'");
>         else
> -       msg (D_MANAGEMENT_DEBUG, "MANAGEMENT: CMD '%s'", line);
> +       msg (D_MANAGEMENT_DEBUG, "MANAGEMENT: GET '%s'", line);


This was probably the result of a sloppy global edit on my part.
Fixed in the updated patch.

Hope this helps
pk.

