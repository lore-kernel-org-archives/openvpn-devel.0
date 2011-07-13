Message-ID: <4E1DF85D.4010705@...515...>
Date: Wed, 13 Jul 2011 12:56:13 -0700
From: =?ISO-8859-1?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
References: <20110713163816.GT32373@...1281...>
In-Reply-To: <20110713163816.GT32373@...1281...>
Subject: Re: [Openvpn-devel] openvpn support for challenge-response
	otp	(user+pass+otp)
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
To: =?ISO-8859-1?Q?Pasi_K=E4rkk=E4inen?= <pasik@...124...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi Pasi,

There's some support for challenge-response authentication in OpenVPN:

<http://openvpn.git.sourceforge.net/git/gitweb.cgi?p=openvpn/openvpn-testing.git;a=commit;h=3cf9dd88fd84108eccfcce0ebf44e00f9481cd82>

This code is in the "master" branch. Look here for instructions on how
to fetch the sources:

<https://community.openvpn.net/openvpn/wiki/DeveloperDocumentation#Maindevelopmentrepositorygit>

Hope this helps,

Samuli

> Hello,
>
> Has anyone implemented challenge-response support to openvpn and openvpn gui?
>
> I'd like to be able to authenticate openvpn users so that all these are required:
> 	1) x509 certificate
> 	2) username + password
> 	3) one time password (otp)
>
> So after the user gets user+pass prompt, and the password is verified to be correct, 
> the user will get another prompt asking for a one time password.
>
> OTP can be delivered as sms to the user, or it could be rsa securid value from the token, or something else..
>
> Openvpn gui would need to be able to present additional prompt after the usual user+pass prompt..
> For example openssh supports challenge-response, so user+pass+otp is possible with it.
>
> Thoughts/plans?
>
> -- Pasi
>
>
> ------------------------------------------------------------------------------
> AppSumo Presents a FREE Video for the SourceForge Community by Eric 
> Ries, the creator of the Lean Startup Methodology on "Lean Startup 
> Secrets Revealed." This video shows you how to validate your ideas, 
> optimize your ideas and identify your business strategy.
> http://p.sf.net/sfu/appsumosfdev2dev
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel


