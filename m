MIME-Version: 1.0
In-Reply-To: <4FD0735C.7090902@...515...>
References: <4FD0735C.7090902@...515...>
Date: Thu, 7 Jun 2012 12:33:19 +0300
Message-ID: <CAOazyz3gNKF8OmTjm+rb_8-Wi0pzuihwh5u_85X-3sgsb3Bqfw@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] PolarSSL 1.1.0 support?
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

On Thu, Jun 7, 2012 at 12:24 PM, Samuli Sepp=C3=A4nen <samuli@...515...> wr=
ote:
> Hi,
>
> I noticed that my Ubuntu 10.04 and 12.04 buildslaves which had PolarSSL
> 1.1.0 failed build during the configure phase:
>
> checking polarssl version... configure: error: invalid polarssl version
>
> Updating to PolarSSL 1.1.1 or later solves this issue. However, commit
> 1d92d06dca5ac says "Removed support for PolarSSL < 1.1", so 1.1.0 should
> work, right?

If 1.1.0 should be supported than I prepare a patch.

