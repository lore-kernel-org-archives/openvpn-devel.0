Date: Wed, 28 Oct 2009 14:57:45 -0500
From: "Karl O. Pinc" <kop@...1206...>
In-Reply-To: <edfc67860910281224x55ec531ala646a288c40641cf@...278...>
	(from lucasmocellin@...277... on Wed Oct 28 14:24:12 2009)
Message-Id: <1256759865.13747.2@...1207...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] How to check is OpenVPN port is open
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
To: Lucas Mocellin <lucasmocellin@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

On 10/28/2009 02:24:12 PM, Lucas Mocellin wrote:
> Hi all,
>=20
> briefly: I'm helping in the development of an educational software to
> apply
> online tests. The client will connect to the server through OpenVPN=20
> to
> perform the test. I would like to check if the OpenVPN port is alive
> and
> accepting connections (check if there is port filtering, and so on..
> ).
>=20
> I'm programming in python.
>=20
> Does someone know to achieve that? I'm trying to create a socket and
> send
> any message to the server, but no response, is there any kind of
> "hello" or
> something like this?

You could re-implement the beginning of the connection but why
not simply use the subprocess module to run openvpn?  You can
see if it succeeds and if not you can capture output and have a
real log from which the user (broadly speaking) can diagnose
the problem.



Karl <kop@...1206...>
Free Software:  "You don't pay back, you pay forward."
                 -- Robert A. Heinlein


