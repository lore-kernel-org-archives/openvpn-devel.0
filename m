MIME-Version: 1.0
In-Reply-To: <55DB4C39.9040105@...2010...>
References: <55DB4C39.9040105@...2010...>
From: grarpamp <grarpamp@...277...>
Date: Tue, 25 Aug 2015 02:38:20 -0400
Message-ID: <CAD2Ti2975xFpu4FrozJgptc4nti3V7aXGebZGfnRS1ynTgaZyw@...278...>
Subject: Re: [Openvpn-devel] Log cert serial no if it is revoked
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

On Mon, Aug 24, 2015 at 12:54 PM, Boris Lytochkin
<lytboris@...2010...> wrote:
> Log serial number of revoked certificate
> In most of situations admin of OpenVPN server needs to know which particular
> certificate is used by client.

Cert serial numbers found in the wild are hardly unique (witness
the Mozilla CA bundle), thus no one with a sane mind refers to them
as identifiers, nor do libraries/apps use them for things like cert pinning,
nor should people be encouraged to think they are unique (even though
there may now be some spec for that, but history precedes). The only place
they'd have meaning is as text string for the local issuer, but it's really just
duplication of work.
The sha1 (or better) fingerprint of the cert should be used instead.

