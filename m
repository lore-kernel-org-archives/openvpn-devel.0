Date: Thu, 14 Jan 2010 15:49:51 -0600
From: "Karl O. Pinc" <kop@...1206...>
References: <lypr5lvsu7.fsf@...1290...>
	<20100109180748.26114.qmail@...1287...>
	<lyr5pxhrp0.fsf@...1290...>
	<20100111133111.2974.qmail@...1287...>
	<lyfx6ciuhm.fsf@...1290...>
In-Reply-To: <lyfx6ciuhm.fsf@...1290...> (from
	enrico.scholz@...1291... on Mon Jan 11 08:31:01 2010)
Message-Id: <1263505791.23987.5@...1207...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] RFE: allow 'lport 0' setup for random port
 binding
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
To: Enrico Scholz <enrico.scholz@...1291...>
Cc: openvpn-devel@lists.sourceforge.net

On 01/11/2010 08:31:01 AM, Enrico Scholz wrote:

>=20
> no; it is because the OpenVPN client creates the same src + dst pair
> for every connection.  I suggest to read some papers about stateful
> firewalls before continuing this discussion.

Enrico is right.  It's in the IP RFC, the 2MSL (twice the maximum
segment lifetime) rule.  (STD 5 is the right rfc?)

I haven't otherwise been following the discussion, but if there's
no other way to do what he wants to do with OpenVPN then
OpenVPN is violating the RFC.


Karl <kop@...1206...>
Free Software:  "You don't pay back, you pay forward."
                 -- Robert A. Heinlein


