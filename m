MIME-Version: 1.0
In-Reply-To: <4C1A0941.5000808@...515...>
References: <4C19ED93.50202@...1380...>
	<4C1A0941.5000808@...515...>
Date: Thu, 17 Jun 2010 15:02:55 +0300
Message-ID: <AANLkTinkGgRbX7tY0QZzoC-ru5jhKFdpiEgn-proJecI@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH] Choose a different field in X509 to be
	username
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: =?UTF-8?Q?Samuli_Sepp=C3=A4nen?= <samuli@...515...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is good idea.

In order to upper case toupper() should be used and not manual guessing.

+  else if (streq (p[0], "x509-username-field") && p[1])
+    {
+      VERIFY_PERMISSION (OPT_P_GENERAL);
+      /* Uppercase if necessary */
+      {
+       char *s =3D p[1];
+       int c, flag =3D 0;
+
+       while ((c =3D *s) !=3D '\0')
+          {
+           if (c >=3D 'a' && c <=3D 'z')
+              {
+                c =3D c + 'A' - 'a';
+               flag++;
+              }
+            *s =3D (char) c;
+            s++;
+         }
+      }
+      options->x509_username_field =3D p[1];
+    }

2010/6/17 Samuli Sepp=C3=A4nen <samuli@...515...>:
>
>> Hi,
>>
>> For my company, we use a PKI (linked to a LDAP) with OpenVPN. We can't
>> use "CN" to be username (few people can have the same "CN"). In our
>> case, we only use the UID.
>>
>> With my patch, you can choose another field to be username with a new
>> option called "x509-username-field", the default value is "CN".
>>
>> Best regards
>>
>> --
>> Emilien Mantel
> Hi Emilien,
>
> Thanks for the patch! Could somebody with better C skills take a look
> and see if it needs modifications?
>
> --
> Samuli Sepp=C3=A4nen
> Community Manager
> OpenVPN Technologies, Inc
>
> irc freenode net: mattock
>
>
> -------------------------------------------------------------------------=
-----
> ThinkGeek and WIRED's GeekDad team up for the Ultimate
> GeekDad Father's Day Giveaway. ONE MASSIVE PRIZE to the
> lucky parental unit. =C2=A0See the prize list and enter to win:
> http://p.sf.net/sfu/thinkgeek-promo
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>

