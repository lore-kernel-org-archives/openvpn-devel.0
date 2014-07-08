Message-ID: <53BBA8F9.30004@...1839...>
Date: Tue, 08 Jul 2014 01:16:57 -0700
From: "Kalnozols, Andris" <andris@...1839...>
MIME-Version: 1.0
References: <1403983176-27674-1-git-send-email-steffan@...1856...>
	<53B1BDD8.8020705@...1856...>
In-Reply-To: <53B1BDD8.8020705@...1856...>
Subject: Re: [Openvpn-devel] [PATCH] Do not upcase x509-username-field for
 mixed-case arguments.
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

Thanks, Steffan, for the comments and code cleanup.  Your method
is definitely safer and has less clutter.  I tested your version
and it works as intended.

Regarding the "ext:" argument prefix, I had submitted an enhanced
version of extract_x509_extension() mainly for more helpful log
messages.  If it doesn't pass muster, then I would suggest that
this function be at least changed as follows:

                    }
                  break;
                default:
-                 msg (D_TLS_ERRORS, "ASN1 ERROR: can not handle field
type %i",
+                 msg (D_TLS_DEBUG, "Ignoring name field type %i",
                       name->type);
                  break;
              }

I don't see the need for alarm if an extension field has additional
GeneralName field types other than "email".

------
Andris


On 6/30/2014 12:43 PM, Steffan Karger wrote:
> Hi,
> 
> The patch below is extracted from Andris Kalnozols' version 2 patch in
> trac ticket #402, annotated with some comments from me.
> 
> The functionality this patch provides makes sense to me, and fixes
> faulty behaviour in both the release/2.3 and master branches. I think a
> final version of this patch should be applied to both branches.
> 
> The options parsing code contains some magic, so I guessed it would be
> the easiest for everyone if I just proposed a new version myself that
> takes care of my comments. You'll find that attached. That version skips
> the string copy at the expense of the reported error, which now only
> reports the upcased x509-username-field, instead of both the original
> and upcased value.
> 
> Andris, could you maybe test this patch and reports whether it indeed
> works as expected for you?
> 
> On 28-06-14 21:19, Andris Kalnozols wrote:
>> From: Andris Kalnozols <andris@...1839...>
>>
>> I revisited options.c to refine its brute-force upcasing behavior. Now, the
>> upcasing is done only if the option argument is all lowercase. Mixed-case
>> arguments and those with the "ext:" prefix are left unchanged. This
>> preserves the original intent of the "helpful" upcasing feature for
>> backwards compatibility while limiting its scope in a straightforward way.
>>
>> Signed-off-by: Andris Kalnozols <andris@...1839...>
>> ---
>>  doc/openvpn.8         | 44 ++++++++++++++++++++++++++++++++++++++------
>>  src/openvpn/options.c | 29 +++++++++++++++++++++++++----
>>  2 files changed, 63 insertions(+), 10 deletions(-)
>>
>> diff --git a/doc/openvpn.8 b/doc/openvpn.8
>> index 14f3129..64247a4 100644
>> --- a/doc/openvpn.8
>> +++ b/doc/openvpn.8
>> @@ -4745,12 +4745,44 @@ the tls-verify script returns.  The file name used for the certificate
>>  is available via the peer_cert environment variable.
>>  .\"*********************************************************
>>  .TP
>> -.B \-\-x509-username-field fieldname
>> -Field in x509 certificate subject to be used as username (default=CN).
>> -.B Fieldname
>> -will be uppercased before matching. When this option is used, the
>> -.B \-\-verify-x509-username
>> -option will match against the chosen fieldname instead of the CN.
>> +.B \-\-x509-username-field [ext:\]fieldname
>> +Field in the X.509 certificate subject to be used as the username (default=CN).
>> +Typically, this option is specified with
>> +.B fieldname
>> +as either of the following:
>> +
>> +.B \-\-x509-username-field
>> +emailAddress
>> +.br
>> +.B \-\-x509-username-field ext:\fRsubjectAltName
>> +
>> +The first example uses the value of the "emailAddress" attribute in the
>> +certificate's Subject field as the username.  The second example uses
>> +the
>> +.B ext:
>> +prefix to signify that the X.509 extension
>> +.B fieldname
>> +"subjectAltName" be searched for an rfc822Name (email) field to be used
>> +as the username.  In cases where there are multiple email addresses
>> +in
>> +.B ext:fieldname\fR,
>> +the last occurrence is chosen.
>> +
>> +When this option is used, the
>> +.B \-\-verify-x509-name
>> +option will match against the chosen
>> +.B fieldname
>> +instead of the Common Name.
>> +
>> +.B Please note:
>> +This option has a feature which will convert an all-lowercase
>> +.B fieldname
>> +to uppercase characters, e.g., ou -> OU.  A mixed-case
>> +.B fieldname
>> +or one having the
>> +.B ext:
>> +prefix will be left as-is.  This automatic upcasing feature
>> +is deprecated and will be removed in a future release.
>>  .\"*********************************************************
>>  .TP
>>  .B \-\-tls-remote name (DEPRECATED)
>> diff --git a/src/openvpn/options.c b/src/openvpn/options.c
>> index 035d3aa..10a8e7f 100644
>> --- a/src/openvpn/options.c
>> +++ b/src/openvpn/options.c
>> @@ -577,8 +577,8 @@ static const char usage_message[] =
>>    "                  and optionally the root CA certificate.\n"
>>  #endif
>>  #ifdef ENABLE_X509ALTUSERNAME
>> -  "--x509-username-field : Field used in x509 certificate to be username.\n"
>> -  "                        Default is CN.\n"
>> +  "--x509-username-field : Field in x509 certificate containing the username.\n"
>> +  "                        Default is CN in the Subject field.\n"
>>  #endif
>>    "--verify-hash   : Specify SHA1 fingerprint for level-1 cert.\n"
>>  #ifdef WIN32
>> @@ -6875,10 +6875,31 @@ add_option (struct options *options,
>>  #ifdef ENABLE_X509ALTUSERNAME
>>    else if (streq (p[0], "x509-username-field") && p[1])
>>      {
>> +      /* This option also introduced a feature to automatically upcase the
>> +       * fieldname passed as the option argument, e.g., "ou" became "OU".
>> +       * Fine-tune this "helpfulness" by only upcasing Subject field
>> +       * attribute names which consist of all lower-case characters.
>> +       * Mixed-case attributes such as "emailAddress" are left as-is.
>> +       * An option parameter having the "ext:" prefix for matching
>> +       * X.509v3 extended fields will also remain unchanged.
>> +       */
>>        char *s = p[1];
>> +      char *l;
>> +      char lowercase_name[OPTION_PARM_SIZE] = { 0 };
> 
> Although this seems reasonable, OPTION_PARM_SIZE actually isn't the
> maximum length of p[1]; parameters supplied on the command line can be
> larger then this.
> 
>> +
>>        VERIFY_PERMISSION (OPT_P_GENERAL);
>> -      if( strncmp ("ext:",s,4) != 0 )
>> -        while ((*s = toupper(*s)) != '\0') s++; /* Uppercase if necessary */
>> +      if (strncmp("ext:", s, 4) != 0)
>> +	{
>> +	  strncpy(lowercase_name, s, strlen(s));
> 
> This actually is a strcpy(lowercase_name, s) that doesn't copy the
> trailing '\0'. In combination with a p[1] that is larger than
> OPTION_PARM_SIZE, this will still happily do an out-of-bounds write.
> 
>> +	  l = lowercase_name;
>> +	  while ((*l = tolower(*l)) != '\0') l++;
>> +	  if (strncmp(s, lowercase_name, strlen(s)) == 0)
>> +	    {
>> +	      while ((*s = toupper(*s)) != '\0') s++;
>> +	      msg(M_WARN, "DEPRECATED FEATURE: automatically upcased the --x509-username-field parameter from '%s' to '%s'; please update your configuration",
>> +		  lowercase_name, p[1]);
>> +	    }
>> +	}
>>        options->x509_username_field = p[1];
>>      }
>>  #endif /* ENABLE_X509ALTUSERNAME */
>>
>>
>>
>> ------------------------------------------------------------------------------
>> Open source business process management suite built on Java and Eclipse
>> Turn processes into business applications with Bonita BPM Community Edition
>> Quickly connect people, data, and systems into organized workflows
>> Winner of BOSSIE, CODIE, OW2 and Gartner awards
>> http://p.sf.net/sfu/Bonitasoft
>>
>>
>> _______________________________________________
>> Openvpn-devel mailing list
>> Openvpn-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/openvpn-devel

