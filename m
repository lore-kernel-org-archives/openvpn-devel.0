Message-ID: <44B3EB63.1090402@...277...>
Date: Tue, 11 Jul 2006 21:18:11 +0300
From: Alon Bar-Lev <alon.barlev@...277...>
MIME-Version: 1.0
References: <06Jul11.104339edt.35585@...699...>
In-Reply-To: <06Jul11.104339edt.35585@...699...>
Subject: Re: [Openvpn-devel] Patch: allow browser as a management GUI
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: P Kern <pak@...698...>
Cc: openvpn-devel@lists.sourceforge.net

P Kern wrote:
> Hello.
> 
> Just fyi - a patch (id 1520128) has been posted to Sourceforge
> which allows a browser to connect to the management interface.
> The patch is based on openvpn-2.1_beta14.
> 
> Since most platforms now have a web browser, this patch could
> lessen the need for a separate OpenVPN management GUI.
> 
> Hope this patch proves useful.
> 
> Paul Kern, CNS, U Toronto.

Hello,

Nice idea!
Just going through your patch...
I have some questions...

Can you please #ifdef all relevant additions, such as:
	HT_send_RAW(man);
	HT_now_reset

I personally don't like multi lines strings... In stead of:
f ("xxxxxx\n\
yyyyy");
Consider:
f ("xxxxxx\n"
   "yyyyyy\n");

Also C concat is not so readable you not just writing HTML?

       len = openvpn_snprintf(ht_getpw, sizeof(ht_getpw),
"<body onLoad=\"document.%s.%s.focus()\">\r\n\
" MAN_self_form "\" name=\"%s\" method=\"post\">\r\n\
" HTML_HIDE_POST "password\"> [%s] Password: \
" HTML_GETPWD "%s\">\r\n " HTML_SUBMIT "\r\n",
                form, type, form, type, type);

-> Something like:
	I think that when the whole form is written it is much more easy to understand what it does.

	len = openvpn_sprintf (ht_getpw, sizeof (ht_getpw),
		(
			"<html>"
			"<body onload=\"document.prompt.pwd.focus()\">"
				"<form name=\"prompt\" method=\"post\">"
					"<input type=\"hidden\" name=\"%s\">"
					"<p>[%s] Password: <input type=\"password\"></p>"
					"<input type=\"submit\" value=\"Submit\"> <input type=\"button\" value=\"cancel\">"
				"</form>"
			"</body>"
			"</html>"
		),
		type, type
	);

	Cancel should be completed... So that both button will submit with hidden action field to be ok or cancel.

	Next stage is to move all these strings into external files... So they can be modified without the need of
	recompilation... I am thinking about translation and such. There can be an option to read these files...
	These files will be much easier to write since you don't have to escape quotes :)

	Also, it is better to have variables in a $0...$N format so that the order may be modified for different languages.
	Better is to insert variables as ${var}... And if you want to go standard, you can parse <%=var%> :)

Why did you change:
        if (parms[0] && streq (parms[0], "password"))
-       msg (D_MANAGEMENT_DEBUG, "MANAGEMENT: CMD 'password [...]'");
+       msg (D_MANAGEMENT_DEBUG, "MANAGEMENT: GET 'password [...]'");
        else
-       msg (D_MANAGEMENT_DEBUG, "MANAGEMENT: CMD '%s'", line);
+       msg (D_MANAGEMENT_DEBUG, "MANAGEMENT: GET '%s'", line);

Best Regards,
Alon Bar-Lev.



