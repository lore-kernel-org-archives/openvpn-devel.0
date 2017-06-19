From: David Sommerseth <davids@...515...>
Date: Mon, 19 Jun 2017 13:11:41 +0200
Message-Id: <20170619111141.17692-1-davids@...515...>
In-Reply-To: <f7ac719e-0b28-4c4d-5e8a-2932827789b6@...2080...>
References: <f7ac719e-0b28-4c4d-5e8a-2932827789b6@...2080...>
Subject: Re: [Openvpn-devel] [PATCH applied] backport: Ignore auth-nocache
 for auth-user-pass if auth-token is pushed
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: davids@...515...
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Your patch has been applied to the release/2.3 branch

commit 199ef1321c77c43ca5151119bef65c7a3d8b716f
Author: David Sommerseth
Date:   Sat Feb 25 14:10:29 2017 +0100

     backport: Ignore auth-nocache for auth-user-pass if auth-token is pushed

         Trac: #840
         Signed-off-by: Antonio Quartulli
         Acked-by: Arne Schwabe
         Message-Id: <20170225004014.28638-1-a@...2181...>
         URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg14194.html

     Signed-off-by: David Sommerseth
     Message-Id: <f7ac719e-0b28-4c4d-5e8a-2932827789b6@...2080...>
     Acked-by: Arne Schwabe
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg14201.html


- --
kind regards,

David Sommerseth

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJZR7FkAAoJEIbPlEyWcf3yikEP/2hNM6ZrkrG+dPO2wDc1zJVl
3radjwCBMWJmXaBIEDMr7c/qauAlThUJSqYtAsWD4Gb1yNxyxm2XzJ/T/DvduWAF
p/pXl/9y6ZeWSxTbmUlyLJmgV4G6wV7X+InztvY6ewTe78JWRN3qf/NPHaO46VlK
vCiB01d3YBRmIaflvhm3/JVWCsiQ22i4VTzdhJ+1hFe8u+QmqW5RRDzI97+RvOlz
qdQJP48DZF80JDgLv+ZshqZF9CfjhaG6c3xj/8kzmExrY1VvLl0HaohHEVlO8NJ3
hqVsgOESy0WzvnPt7uP2o8+Emy3eY6m3qz6Kw75mppU/1Ts0XH7JT3hOQn3OUjE5
hGDv4FvtEoUnw5SjZllvJmghJF17siqfijsT4OdWbPwtgi5FOuva18EjeIHhnxlm
EXDZwld69daLtluKfSW+lmtDrjjgHXyC3jQxjzUJ2z4bav+ZoEMG67WBHphpSbVY
QdIqpKzuqXjdJrNNeIKOQXtlzAzQAlyvW916YK1DVwTFnb8X87Fi2vxbPKqq1i2E
zQVAz+YEnc/oXGbODFA2yB/5udOpTTNFdxrDQ79gKBYwlrpJyo/9/IUv62lE8LdT
oq5YTMeQ/n++peKVrYEjKa7737Q+jsybc51liD4eywjKiIrxvnVLiHdztp2/qBpU
qHg9V6wdtnEhrd2vwcld
=I6qm
-----END PGP SIGNATURE-----

