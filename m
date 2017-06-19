From: David Sommerseth <davids@...515...>
Date: Mon, 19 Jun 2017 15:28:22 +0200
Message-Id: <20170619132822.27713-1-davids@...515...>
In-Reply-To: <20170619130507.13892-1-davids@...515...>
References: <20170619130507.13892-1-davids@...515...>
Subject: Re: [Openvpn-devel] [PATCH applied] auth-token with auth-nocache
 fix broke --disable-crypto builds
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

Your patch has been applied to the following branches

commit 5bde5b6d1875fd87b116c943084df0d2f6aee6d0  (master)
commit df5efe7e2cd23b2282526f2c41be2063d941dff1  (release/2.4)
commit 888b0dcee0e03a80f202005914b81ccb17a27eab  (release/2.3)
Author: David Sommerseth
Date:   Mon Jun 19 15:05:07 2017 +0200

     auth-token with auth-nocache fix broke --disable-crypto builds

     Signed-off-by: David Sommerseth
     Acked-by: Gert Doering
     Message-Id: <20170619130507.13892-1-davids@...515...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg14883.html


- --
kind regards,

David Sommerseth

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJZR9FtAAoJEIbPlEyWcf3yKxcP/1k6mfayyFHT49v/AFduuWqm
EYsX+q1d+RQvJi/0PopAcdnD9DHmQiR6f3/slRPWa1YlP1UJKx7SCYSuxJJoQ4aJ
4lSGresernxIl5LAzlzZo3ohRR3VJZhWM7fyeuFCm5kcw7PRsxQoHHz9yfS29F7O
Jzpg8nA6ZJ0pL1QX/T1GapGx0oFY3h/H1vxIkhcZnA0d9rkjqPHX4kUiXSLs49Cq
iycUIr75+fMrIia3GMhoF/OjGiGLnxo251ig//YjnEcEnM1MLKlfCL6y2pkpj9ic
ff6t79uO7vmMP9iCSoI+C4JESBCoyjWtDEmTx4jF/dyy2Dq8wz81wuImrTkk6EGY
LkWZ6dPFxPAFD3wxU0vli9GM8TviuECGppyqjiMreLM/0O4wMHfIkS00TNi1+WYF
/AxpyzRiNwLmBbVq+UD+DZhf5X02LErtAYIk2Hlfo/e/Rn819NVCpB+w6fBl1Hf7
7Bb3dI7nWlWMRQoqUelpQ7nnC4f6FGU8ALMM1TzgHCaczAqoh31gRpyXuDkO6+k+
nJAouJLOrMB4Zg4QxsYNoYU/tw80dnO5VnGj7Qi8GrBdyKOiJsnD5zpGYJlPyu5o
P0ocMCwnac3GtCiui4N34fb/eVd6LkQaf+CjyiK0+THHyGRUrKkTvLJlHZC7fjQm
sG10Hp4LW4IQF+ELL0LP
=NWJC
-----END PGP SIGNATURE-----

