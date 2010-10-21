Date: Thu, 21 Oct 2010 10:38:52 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20101021083852.GK10703@...1296...>
References: <4CBC6CD4.7000103@...1418...>
	<20101018164138.GB16573@...1330...>
	<20101020193135.GE10703@...1296...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rQvkTxYCHmztyjwM"
Content-Disposition: inline
In-Reply-To: <20101020193135.GE10703@...1296...>
Subject: Re: [Openvpn-devel] Errors adding routes on Windows 7 with OpenVPN
	2.1.3
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--rQvkTxYCHmztyjwM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Oct 20, 2010 at 09:31:35PM +0200, Gert Doering wrote:
> I think the patch below should fix this, but have not tested this at all
> (neither with nor without the patch).  Applies to tag v2.1.3

David suggested to use CLEAR() to make easier-understandable code and
more thorough clearing.  Patch (goes on top of the last patch) below.

Agi, either patch should work, but if you haven't tested the other one
yet, please test this one.

gert

--rQvkTxYCHmztyjwM--
