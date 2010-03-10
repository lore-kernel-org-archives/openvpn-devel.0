MIME-Version: 1.0
In-Reply-To: <4B97CDF3.6060703@...1114...>
References: <1268218182-21015-1-git-send-email-openvpn.list@...1114...>
	<4B978D0E.9090606@...1114...>
	<9e0cf0bf1003100842r408389c7occa7dcf0d27ad59a@...278...>
	<4B97CDF3.6060703@...1114...>
Date: Wed, 10 Mar 2010 19:03:12 +0200
Message-ID: <9e0cf0bf1003100903k3647ba78t40bb93d5d9a5d8d8@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH] On TARGET_LINUX define _GNU_SOURCE if
	not defined
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
To: David Sommerseth <openvpn.list@...1114...>
Cc: openvpn-devel@lists.sourceforge.net

On Wed, Mar 10, 2010 at 6:50 PM, David Sommerseth
<openvpn.list@...1114...> wrote:
> I'm willing to accept patches with updates as long as it don't break the
> oldest version OpenVPN need to support (autotools/autoconf v2.59). =C2=A0=
If
> it can be built an old RHEL4.6 installation, it's good enough for James,
> according to the last meeting.

This is the root cause of the mistake.
You don't have any dependency in the versions of
autoconf/automake/libtool at target machine.
These tools are used at the packager machine in order to generate
whatever needed in order to successfully compile on target machine.
So there is no need to support old versions of these tools.
The decent versions are >=3Dautoconf-2.60 >=3Dautomake-1.10 >=3Dlibtool-1.5=
.26

