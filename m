MIME-Version: 1.0
In-Reply-To: <20110514160158.GQ8496@...1296...>
References: <BANLkTimDEA004RuTcUBKDXPWffEWBo3-iw@...278...>
	<20110514120304.GO8496@...1296...> <4DCE76E9.4070806@...68...>
	<20110514160158.GQ8496@...1296...>
Date: Sat, 14 May 2011 14:15:14 -0400
Message-ID: <BANLkTinvu2UfT6ddNzqLtCupe5CmJTGd_Q@...278...>
From: "Matthew L. Creech" <mlcreech@...277...>
Subject: Re: [Openvpn-devel] [PATCH] fix 2.2.0 build failure when management
 interface disabled
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
To: Gert Doering <gert@...1296...>
Cc: Matthias Andree <matthias.andree@...68...>, openvpn-devel@lists.sourceforge.net

On Sat, May 14, 2011 at 12:01 PM, Gert Doering <gert@...1296...> wrote:
>
> I'm not exactly sure why one would want openvpn without management
> interface, except for "embedded systems, as small as possible" - and
> we have "--enable-small" for those already. =A0So maybe one could merge
> "--disable-management" and "--enable-small"... =A0one less variant.
>

Indeed that's the case here - I'm using OpenVPN on an embedded PPC
device to phone back home to a data collection server, so I've got
something like:

--disable-plugins --disable-management --disable-debug --enable-small
--disable-selinux

--=20
Matthew L. Creech

