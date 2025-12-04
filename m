Date: Thu, 4 Dec 2025 15:17:17 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <aTGX7VVc7-vuxr-T@...1296...>
References: <2021d22e93620793b0fd0e331878121c.20251129190809.1764439689@...2556...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="0YeYkLmfTfijIXss"
Content-Disposition: inline
In-Reply-To: <2021d22e93620793b0fd0e331878121c.20251129190809.1764439689@...2556...>
Subject: Re: [Openvpn-devel] [Openvpn-users] OpenVPN 2.7_rc3 released
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Simon Matter <simon.matter@...2249...>
Cc: openvpn-devel@lists.sourceforge.net

--0YeYkLmfTfijIXss
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sat, Nov 29, 2025 at 07:08:09PM +0100, Simon Matter via Openvpn-devel wr=
ote:
> The patch is attached to this email. Would be nice if it was considered.

I have turned this into a proper commit with all the extra references
we want to have in our codebase.

commit 864aab8a6cb9c473629bab2b6d5d0338d2d64186 (HEAD -> master)
Author: Simon Matter <simon.matter@...2249...>
Date:   Thu Dec 4 15:05:27 2025 +0100

    Add CAP_SYS_NICE to the positive list in systemd service files
=20=20=20=20
    This is necessary to make the ``--nice n`` option work for OpenVPN
    instances started by systemd.
=20=20=20=20
    Github: closes OpenVPN/openvpn#834
=20=20=20=20
    Signed-off-by: Simon Matter <simon.matter@...2249...>
    Acked-By: Arne Schwabe <arne@...1227...>
    Message-Id: <f58b64307a86c62cb20a142ebfb40e56.20251204111659.1764843419=
@...2556...>
    URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/m=
sg34803.html
    Signed-off-by: Gert Doering <gert@...1296...>


... for the next patch, please learn how to use git for simple changes
like this - who can do a "diff -u oldfile newfile" can also do a=20
"git commit ; git format-patch -1" to produce a patch with sufficient
git stuff around that I have to spend less time on it.
--0YeYkLmfTfijIXss--
