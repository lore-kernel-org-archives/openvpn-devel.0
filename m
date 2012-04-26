MIME-Version: 1.0
Sender: fabian@...1547...
In-Reply-To: <1335441085-18186-1-git-send-email-davids@...1347...>
References: <1335441085-18186-1-git-send-email-davids@...1347...>
From: Fabian Knittel <fabian.knittel@...1547...>
Date: Thu, 26 Apr 2012 15:11:54 +0200
Message-ID: <CAP+U6tKVWNkD0fF8pLyFXUMX2+-yTYTJihoix9bkigzYiEWXkw@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Presume that Linux is always IPv6
 capable at build time
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
To: David Sommerseth <davids@...1347...>
Cc: openvpn-devel@lists.sourceforge.net

Hi David,

2012/4/26 David Sommerseth <davids@...1347...>:
> These days it is highly unlikely that OpenVPN will be built in a non-IPv6
> capable Linux environment.

Agreed.

> This also solves an issue which was introduced in commit 51bd56f46f55177c=
f0f8b
> where HAVE_TUN_PI and HAVE_IPHDR is no longer detected. =C2=A0As these ma=
cros where
> only used to detect if IPv6 support was available on Linux, it makes no s=
ense
> looking for them any more.

Gert appears to be happy, so I'm happy, but I don't quite understand
what you're saying here. What part broke? HAVE_TUN_PI and HAVE_IPHDR
aren't always detected although they should be? Or the failed
detection affects non-Linux systems? Something else? Just curious ...

Cheers
Fabian

