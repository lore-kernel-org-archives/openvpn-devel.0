MIME-Version: 1.0
In-Reply-To: <4F55E287.2000903@...515...>
References: <1330546342-17794-1-git-send-email-alon.barlev@...277...>
	<1330546342-17794-5-git-send-email-alon.barlev@...277...>
	<4F55E287.2000903@...515...>
Date: Tue, 6 Mar 2012 13:25:55 +0200
Message-ID: <CAOazyz35Mn-MDo1J_XYFR2ZdGQUk=s2kfHwpwwq-zsF0u_mUVQ@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH 04/52] cleanup: remove C++ warnings
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
Cc: "Openvpn-devel@lists.sourceforge.net" <Openvpn-devel@lists.sourceforge.net>

2012/3/6 Samuli Sepp=C3=A4nen <samuli@...515...>:
> Although this commenting style has been valid in C since C99 (year
> 2000), the actual C99 implementations seem to be incomplete[2]. So, just
> to be on the safe side, I'll give this one an ACK.

As long as we need to support old machines, we need to support C89.
There is much work to be done to cleanup warnings gcc produces using
-pendatic -Wall -Wextra.
But cleaning these will improve the ability to find issues.

Alon.

