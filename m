Date: Wed, 10 Mar 2010 11:44:39 -0600
From: "Karl O. Pinc" <kop@...1206...>
References: <1268218182-21015-1-git-send-email-openvpn.list@...1114...>
	<4B978D0E.9090606@...1114...>
	<9e0cf0bf1003100842r408389c7occa7dcf0d27ad59a@...278...>
	<4B97CDF3.6060703@...1114...>
	<9e0cf0bf1003100903k3647ba78t40bb93d5d9a5d8d8@...278...>
	<4B97D385.3010506@...1114...>
	<20100310172636.20173.qmail@...1287...>
	<4B97D8F5.5080503@...1114...>
In-Reply-To: <4B97D8F5.5080503@...1114...> (from
	openvpn.list@...1114... on Wed Mar 10 11:37:57 2010)
Message-Id: <1268243079.8679.1@...1207...>
MIME-Version: 1.0
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: David Sommerseth <openvpn.list@...1114...>
Cc: openvpn-devel@lists.sourceforge.net

On 03/10/2010 11:37:57 AM, David Sommerseth wrote:
> On 10/03/10 18:26, Peter Stuge wrote:

> > The only way autoconf on that RHEL4.6 would be relevant is if those
> > RHEL4.6 systems strictly need to build directly from git source, as
> > opposed to building from a prepared tarball. Is that the case?
>=20
> I will get that clarified on the meeting tomorrow, as this might be a
> scenario.  But to be honest, I have troubles seeing that people want
> to
> do active development on RHEL4.6, at least do changes which require
> changing autotools files or pulling down SVN or git trees.

And, to reiterate, applying patches within an rpm
spec file is normal, expected, and part of the
rpm design so a certain level of "development" is supported.




Karl <kop@...1206...>
Free Software:  "You don't pay back, you pay forward."
                 -- Robert A. Heinlein


