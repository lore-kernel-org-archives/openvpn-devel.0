From: David Sommerseth <davids@...515...>
Date: Thu, 20 Feb 2020 19:19:50 +0100
Message-Id: <20200220181951.7603-6-davids@...515...>
In-Reply-To: <20200220181951.7603-1-davids@...515...>
References: <20200220181951.7603-1-davids@...515...>
Subject: Re: [Openvpn-devel] [PATCH applied] Fix possibly uninitialized
 return value in GetOpenvpnSettings()
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
To: openvpn-devel@lists.sourceforge.net, Selva Nair <selva.nair@...277...>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

Your patch has been applied to the master branch

commit e1f7d7885752ac3a0279ecc7e31ccee2af40fbe4
Author: Selva Nair
Date:   Wed Feb 19 19:49:37 2020 -0500

     Fix possibly uninitialized return value in GetOpenvpnSettings()

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Lev Stipakov <lstipakov@...277...>
     Message-Id: <1582159777-2437-1-git-send-email-selva.nair@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg19479.html
     Signed-off-by: David Sommerseth <davids@...515...>


- --
kind regards,

David Sommerseth

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJeTsaVAAoJEIbPlEyWcf3yC3UP/1i/BYgIF0RXaUY4ghyOZcWk
zuDvSrwBu2xCBNjV31h060vIDpLkV7hFNpN1/sxnDblQE2k+R5kInLfJHQs1vDs6
DzyexfFgmZDxexjXkNpUCRfHwL1u1Jv7OFjXGk93OnmUhxIRFtj+ik9RgLG0Hwae
vf+uj5Df1LXRRaCb8Psxg2gubcQU800XNZDVhrtCEaaiDjdz691C6ptTBzCNzAIQ
6ptwz2axAzmlIi5QunPKwSmBu5WHrf0azQs2P6adxxRhZyw1a3A3ZadxcgTur+Xj
SvD2MNixlmUAm8AbYroQ88sttdExYPR4lasw1l3fDICICcvMj3Eo3bArcD0mfips
3qWIib4cCMQ8EwwSaE9l//fYHcJTvSnKkAhzzQvCcKpbIP0Sl4AYjrZomWwD07bk
R6uX2VMc8yBKy8ZYt14mhhxYFpKa2R7UUHagUQXFuiIRppEglnblHJXz89jaUzTj
gSJpPDLhrpsg1RLKHhVf3O6T7FKe7ZVu4bek9iICC3lNBJx7k9Kr1ufCPaeO5bD5
+KnPwEX5tK83Xs5fLnAY14iT9PypmCMEn+4AvyoA60dNL56xCUUntRNaD4un57Bg
KHoKg69qRCW4Fmr00e3mf40bZaa6PNRZ8A966GgVUFacg0f6inufrVoP+tRFzZqZ
dfiltjeR5NdkBSsuMIVL
=55lQ
-----END PGP SIGNATURE-----

