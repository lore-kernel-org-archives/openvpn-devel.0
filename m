Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
From: Jens <openvpn-devel@...2127...>
In-Reply-To: <CAA1AbxL3ZRGrig+j9uTdn17NDaM=WGbE4XgZf1nAyvXBxTwfBg@...278...>
Date: Thu, 21 Apr 2016 08:51:27 +0200
Message-Id: <A4F03DE4-3E70-4815-B4B4-CC185E35CF2C@...2127...>
References: <B32C1FDE-D0CF-49A7-A231-28267BB89B46@...2127...>
	<CAA1AbxL3ZRGrig+j9uTdn17NDaM=WGbE4XgZf1nAyvXBxTwfBg@...278...>
Subject: Re: [Openvpn-devel] [PATCH] auth-pam:Fix buffer overflow by user
	supplied data
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel <Openvpn-devel@lists.sourceforge.net>

Hi Steffan,

[=E2=80=A6]

>=20
> This is without a doubt an improvement, but it still leaves an
> opportunity open to achieve a buffer overflow through an integer
> overflow.  Consider a tosearch with len 11, and a replacewith with len

[=E2=80=A6]

Good point. Patch attached.

Cheers
Jens

