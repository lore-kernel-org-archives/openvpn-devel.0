MIME-Version: 1.0
Sender: flagel@...277...
In-Reply-To: <4E4B873F.6080009@...515...>
References: <CANdUpHPLMwTJRD69vo+ZUQi=wFQEX=s-5Lt72Xhvn+dW+1WtwA@...278...>
	<4E4B873F.6080009@...515...>
Date: Thu, 18 Aug 2011 14:30:26 +0200
Message-ID: <CANdUpHMjF43pmSO=2K_T-hAy+iY9dEYPE4n3YOVGvch_fZhCuw@...278...>
From: Tanel Rebane <tanel@...1495...>
Subject: Re: [Openvpn-devel] [PATCH] Make easy-rsa/2.0/vars handle paths
	with whitespaces
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
To: =?ISO-8859-1?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

As I've understood, the second approach is safer, but the first one is
more portable. Then again, don't hold me to it as I have no sources
available (other than myself) confirming that.

I also noticed that easy-rsa/2.0/build-dh has issues with whitespaces.
This can easily be fixed with some double-quotes on line 6 and 7.

The current...
if [ -d $KEY_DIR ] && [ $KEY_SIZE ]; then
    $OPENSSL dhparam -out ${KEY_DIR}/dh${KEY_SIZE}.pem ${KEY_SIZE}

...becomes:
if [ -d "$KEY_DIR" ] && [ "$KEY_SIZE" ]; then
    "$OPENSSL" dhparam -out "$KEY_DIR"/dh"$KEY_SIZE".pem "$KEY_SIZE"

Also, I don't see the point of those curly brackets, might as well
keep it consistent.

I general I think it would be a good idea to run a "grep '$'
easy-rsa/2.0/*" and make sure that variables are properly quoted.

Regards,
Tanel Rebane


2011/8/17 Samuli Sepp=E4nen <samuli@...515...>:
>
>> Hello,
>>
>> Line 29 of vars, export KEY_CONFIG=3D`$EASY_RSA/whichopensslcnf
>> $EASY_RSA`, cannot handle whitespaces contained in $EASY_RSA. This
>> line could be changed - depending on preference - to either of:
>> a) export KEY_CONFIG=3D"`"${EASY_RSA}"/whichopensslcnf "${EASY_RSA}"`"
>> b) export KEY_CONFIG=3D$("${EASY_RSA}"/whichopensslcnf "${EASY_RSA}")
>>
>> Regards,
>> Tanel Rebane
>>
>> ------------------------------------------------------------------------=
------
>> FREE DOWNLOAD - uberSVN with Social Coding for Subversion.
>> Subversion made easy with a complete admin console. Easy
>> to use, easy to manage, easy to install, easy to extend.
>> Get a Free download of the new open ALM Subversion platform now.
>> http://p.sf.net/sfu/wandisco-dev2dev
>> _______________________________________________
>> Openvpn-devel mailing list
>> Openvpn-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
> Hi Tanel,
>
> Both approaches seem POSIX-compliant. I'll do some tests and send in a
> proper patch.
>
> Btw. I noted that some of the easy-rsa scripts lack the customary
> interpreter line (e.g. #!/bin/sh). We should probably fix that, too.
>
> --
>
> Samuli Sepp=E4nen
> Community Manager
> OpenVPN Technologies, Inc
>
> irc freenode net: mattock
>
>
>
>

