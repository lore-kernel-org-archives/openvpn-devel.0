Message-ID: <536B10C1.9090700@...1147...>
Date: Thu, 08 May 2014 07:06:09 +0200
From: Jan Just Keijser <janjust@...1147...>
MIME-Version: 1.0
References: <536ADECA.8040807@...1839...>
In-Reply-To: <536ADECA.8040807@...1839...>
Subject: Re: [Openvpn-devel] Questionable restriction in
	--x509-username-field
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Andris Kalnozols <andris@...1839...>, openvpn-devel@lists.sourceforge.net

Hi Andris,

On 08/05/14 03:32, Andris Kalnozols wrote:
> The X.509 user certificates in our organization have Subject fields
> that appear as in the following example:
>
>    Subject: O=Hewlett-Packard Company, OU=WEB,
>    CN=GivenName Surname/emailAddress=user@...1911...
>
> Since the Common Name (CN) attribute is not guaranteed to be unique
> across the company but the "emailAddress" attribute is, I was very
> glad to see the availablity of the "--x509-username-field" option.
>
> However, the following code in src/openvpn/options.c prevents the
> option from working as intended:
>
>> #ifdef ENABLE_X509ALTUSERNAME
>>    else if (streq (p[0], "x509-username-field") && p[1])
>>      {
>>        char *s = p[1];
>>        VERIFY_PERMISSION (OPT_P_GENERAL);
>>   ???  if( strncmp ("ext:",s,4) != 0 )
>>   ???    while ((*s = toupper(*s)) != '\0') s++; /* Uppercase if necessary */
>>        options->x509_username_field = p[1];
>>      }
>> #endif /* ENABLE_X509ALTUSERNAME */
> RFC 2985 specifies that the emailAddress attribute is case-insensitive:
>
>>     emailAddress ATTRIBUTE ::= {
>>             WITH SYNTAX IA5String (SIZE(1..pkcs-9-ub-emailAddress))
>>             EQUALITY MATCHING RULE pkcs9CaseIgnoreMatch
>>             ID pkcs-9-at-emailAdress
>>     }
> While the "pkcs9CaseIgnoreMatch" match rule probably refers to the
> email address(es) to which the attribute point(s), I can find no
> requirement in the RFCs which require that the attributes themselves
> be prefixed with "ext:" to preserve their character case when being
> matched by an X.509 application.  I think the "if" statement needs
> to be removed.
>
>
I'm not one the core developers of openvpn, but I think I've read the 
code often enough.
The way I see the openvpn code is as this:
   if the x509-username-field starts with "ext:" then uppercase the 
entire attribute name.
This means that openvpn will do a case-insensitive match for this 
particular attribute *name* in a certificate *extension* (e.g a 
subjectAltName extension)

Without "ext:" openvpn will do a case sensitive match in the full 
certificate DN (e.g. /emailAddress=.....)
There's no reason for openvpn to do a case insensitive match here - that 
would mean that there are two simultaneous connections with two 
certificates DNs
   /emailAddress=joe@...1113...
   /emailAddress=joe@...1912...
which need to be matched/merged - this can not happen , as far as I 
understand.

If extended validation (user auth) based on /emailAddress= is necessary 
then a 'tls-verify' script can be used to do a case insensitive check.

HTH,

JJK


