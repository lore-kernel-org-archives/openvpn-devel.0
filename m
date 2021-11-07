MIME-Version: 1.0
References: <CAKuzo_gHxUQfam=J8uKtMAL2ma_Vu0zZcOBMgGHy4BtcQ5panw@...278...>
In-Reply-To: <CAKuzo_gHxUQfam=J8uKtMAL2ma_Vu0zZcOBMgGHy4BtcQ5panw@...278...>
From: Lev Stipakov <lstipakov@...277...>
Date: Sun, 7 Nov 2021 15:14:28 +0100
Message-ID: <CAGyAFMXvP0iwEiE-G4-d6P4ANSRpr9w-tF++VDL-amgrmPmGuQ@...278...>
Subject: Re: [Openvpn-devel] OpenSSL build on Windows: OPENSSLDIR and
 MODULESDIR
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

We agreed during the hackathon that we are going to ship a 2.6 Windows
client with OpenSSL 3.0. Apart from merging relevant patches, there
are few (small) blocks:

 - vcpkg hasn't yet added OpenSSL 3.0 to official repo, but there is a
PR https://github.com/microsoft/vcpkg/pull/20428 This shouldn't be a
problem for us, since we could just have this port in openvpn repo,
like we do with pkcs11-helper.

 - The latest release of pkcs11-helper doesn't build with openssl3,
but things are progressing -
https://github.com/OpenSC/pkcs11-helper/issues/42. We would also have
to make sure that our vcpkg port for pkcs11-helper builds with
openssl3.

Once OpenSSL 3.0 support is somewhat settled, we could look into
configuration file loading. I haven't checked vcpkg scripts, but in
the best case scenario we won't have to do anything and just rely on
readonly values you've mentioned.

--
-Lev

