From: David Sommerseth <davids@...515...>
Date: Mon,  8 May 2017 18:22:09 +0200
Message-Id: <20170508162209.8274-1-davids@...515...>
In-Reply-To: <1494154878-18403-1-git-send-email-steffan@...1856...>
References: <1494154878-18403-1-git-send-email-steffan@...1856...>
Subject: Re: [Openvpn-devel] [PATCH applied] Fix memory leak in
	x509_verify_cert_ku()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: steffan@...1856...
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Looking good to me.  ACK!

Your patch has been applied to the following branches

commit 7b94d3bbbea46efcea12e1df24da52fe508d0173  (master)
commit d7a13af789daecf38fb6a3ca2d6e6cf0ab939a73  (release/2.4)
Author: Steffan Karger
Date:   Sun May 7 13:01:18 2017 +0200

     Fix memory leak in x509_verify_cert_ku()

     Signed-off-by: Steffan Karger <steffan@...1856...>
     Acked-by: David Sommerseth <davids@...515...>
     Message-Id: <1494154878-18403-1-git-send-email-steffan@...1856...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg14563.html
     Signed-off-by: David Sommerseth <davids@...515...>


- --
kind regards,

David Sommerseth

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJZEJswAAoJEIbPlEyWcf3ys1oP/jeCx+xu9GRMbcgR3hudPHQY
c7ujhO0jvRMbWdaFtdNcX9QDfVSTCHAnAyGSnI/z33oQIz45uI3PS+Z3O3KwrOdQ
2ZI5UnG1l/QlBvdDvsD9dCNxTIzTXwHLPAxLtL4KsRMlefZPPYC5W9ziMkEBcYvr
wLEShlK8IFx3zpU+wpND9xvBTA71wPQmzKqtJYv6O7qI+7FZUEphFGDmVdu4hPxu
/owH6BCBqxCK9Tkcg7tJeMfIdZ+1dQz1fG6rLz/HVtDdRDq/FtT/3wISTMqKmmsL
ugwGm39v3QaDuHQzOyCr2ORX6Ht44AbMwjgyDnblg9rWvsRy/wWCOFSaJqQdPQVV
BquYDh3tALcCkCMByMQDnXZkeKww+3bIxOEagj1f0C+RjzzUT87OoWm/qOj/jLs+
fvEnZTf4Zeh5Icx2Xd0kEHzM2+Y9q06qm6iZoAgDI383mvgTcQNXCzAHQijEsZC1
mlJ65GWQcdgAB+A3vUPuy1qoUSyB5ZGucCLebGpn4THyzeMC3ihWn1shxlH66XoL
GeKvuJmyRWjTItuLg0CHles1/11XQSCeBqrkJKgKS51IOistpP2Pgy6tyS5POIzn
Q/DP7O+n3g3ezU/mB7UQ2/ctpk938iq/ecMEtD3/qH8MxQd8Abq2QwbjBAj6gT6N
tiHhKxFdQTy9bw/uSVjZ
=gRag
-----END PGP SIGNATURE-----

