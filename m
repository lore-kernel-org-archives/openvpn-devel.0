From: David Sommerseth <openvpn@...2080...>
Message-ID: <c089f77e-a15d-c5ff-2b9a-3425672ff1ad@...2080...>
Date: Wed, 16 Nov 2016 17:05:54 +0100
MIME-Version: 1.0
Subject: [Openvpn-devel] Issues with sourceforge.net git services
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


Hi,

Sourceforge.net have some serious issues with their git services, which
makes it currently impossible for us to push updated git trees there
(pulling works though).  So neither openvpn.git nor openvpn-testing.git
on sourceforge.net is up-to-date unfortunately.

To provide a possibility to verify the state of our git trees, I have
added another public git tree at GitLab:

     <https://gitlab.com/openvpn/openvpn>

This comes in addition to GitHub:

     <https://github.com/OpenVPN/openvpn/>

as well as the git trees on sourceforge.net (which are not yet
up-to-date).

We might decide to postpone the planned release of OpenVPN 2.4_beta1 to
tomorrow due to these issue, as our buildbots are coupled against
sourceforge.net git repos.  Unless we adjust them to fetch changes from
gitlab or github.


- -- 
kind regards,

David Sommerseth
OpenVPN Technologies, Inc


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJYLIPiAAoJEIbPlEyWcf3ypwYQAJlrtDauZ4C9Qm4rykcRfOyK
f7AtUm94vVujkw03ZDQBp990VnhM0+cFexZBV/igTPctMn8loCQkIjnB7/MskTxo
SUYLUurgeI8ge9e/pxH6pr3pp1rv4fACz6I4VtU6P4lCpahlwSzqrav3MX/dIfIZ
99D3yThf7ReBJ8A1e8h7Kqlv9S0cTna7J4/BUJr9XKvla5c8EhO+t3yW45OzIbDO
YKCK+v9o8LOh0TFgOsnPRDXWRDdzMS8T8Tsdq9WsQrPaDX8oXERQZQb/ySw+chnA
BD9suH4QnhKVad/CLusi/PIaQ0j0bYtj+rYBuVbOuydhlm09EXWBlc28IgqA5Yzc
LBVdGWowVmHYmXRZnq0DZ7JjU2pWu99FE384AXLivysTHUMe70UQhAT+4DheXEBG
ZmacCuogOFBt2mFLaa7Zzn1BUUM4wmmYukHXtGr5y+B9rLRUIDhq+7eNVvyiCAKC
HXzIXUGzvVPVu9o8qdU33RrwA5uFWDhf1rjCzAMrkMFyws0lP1xoDGKBuHR9MskR
/QJs1D0FytXqBGuNJor1Qq7hg0GG6FuililrWiA6o0rdvNrf6DRKgw8R0Ks60f1h
jn64olj/5xm0jAaL74yxBsgiEF9BuPbuvx7HlGFSAOrEjZW0O+s1rkrBrC7vofM4
RfNLrFRnN5PEruPUOggp
=ohIY
-----END PGP SIGNATURE-----

