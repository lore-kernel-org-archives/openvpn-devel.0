Message-ID: <536ADECA.8040807@...1839...>
Date: Wed, 07 May 2014 18:32:58 -0700
From: Andris Kalnozols <andris@...1839...>
MIME-Version: 1.0
Subject: [Openvpn-devel] Questionable restriction in --x509-username-field
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

The X.509 user certificates in our organization have Subject fields
that appear as in the following example:

  Subject: O=Hewlett-Packard Company, OU=WEB,
  CN=GivenName Surname/emailAddress=user@...1911...

Since the Common Name (CN) attribute is not guaranteed to be unique
across the company but the "emailAddress" attribute is, I was very
glad to see the availablity of the "--x509-username-field" option.

However, the following code in src/openvpn/options.c prevents the
option from working as intended:

> #ifdef ENABLE_X509ALTUSERNAME
>   else if (streq (p[0], "x509-username-field") && p[1])
>     {
>       char *s = p[1];
>       VERIFY_PERMISSION (OPT_P_GENERAL);
>  ???  if( strncmp ("ext:",s,4) != 0 )
>  ???    while ((*s = toupper(*s)) != '\0') s++; /* Uppercase if necessary */
>       options->x509_username_field = p[1];
>     }
> #endif /* ENABLE_X509ALTUSERNAME */

RFC 2985 specifies that the emailAddress attribute is case-insensitive:

>    emailAddress ATTRIBUTE ::= {
>            WITH SYNTAX IA5String (SIZE(1..pkcs-9-ub-emailAddress))
>            EQUALITY MATCHING RULE pkcs9CaseIgnoreMatch
>            ID pkcs-9-at-emailAdress
>    }

While the "pkcs9CaseIgnoreMatch" match rule probably refers to the
email address(es) to which the attribute point(s), I can find no
requirement in the RFCs which require that the attributes themselves
be prefixed with "ext:" to preserve their character case when being
matched by an X.509 application.  I think the "if" statement needs
to be removed.

------
Andris Kalnozols
HP Labs, Palo Alo


