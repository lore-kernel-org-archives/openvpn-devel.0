Date: Wed, 6 Mar 2024 14:24:57 +0100
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <ZehuqZx1dir/Q8p2@...2685...>
References: <CAEeEfvzkhp_FQ8cnOZcASiVbDN8=+Gw_2sV5SNonL5x7OYb1jA@...278...>
 <892bc3fa-b752-b959-1ea4-19b106c0915c@...1227...>
 <CAEeEfvyw2AKiKV1DW2mPA8C332pK7nroA9=BtpqEND2TPGmFog@...278...>
 <ffffcce0-1c0b-cd4e-95c5-b17d523cbf30@...2108...>
MIME-Version: 1.0
In-Reply-To: <ffffcce0-1c0b-cd4e-95c5-b17d523cbf30@...2108...>
Subject: Re: [Openvpn-devel] [PATCH OpenVPN3] Add 'pull' to ignored options
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: David Sommerseth <dazo+openvpn@...2108...>
Cc: Merten Fermont <merten.fermont@...277...>, openvpn-devel@lists.sourceforge.net

On Tue, Aug 01, 2023 at 08:22:24PM +0200, David Sommerseth wrote:
> On 27/07/2023 14:21, Merten Fermont wrote:
> > Hi Arne,
> > 
> > I changed my patch to check the client and client+pull options.
> > Giving an error when neither options are declared.
> > 
> > This however may break current implementations that depend on 'client'
> > not being a required option?
> > 
> > Greetings,
> > Merten
> > 
> > Subject: [PATCH] Check for client options
> > 
> 
> Hi,
> 
> Thanks for your patch.  Changes looks reasonable to me as well, and I wanted
> to pull it in.  But it turns out that the patch has been mangled somehow.
> Even good old 'patch' refuses to apply anything.  This is not an unknown
> issue with gmail.com; which is why we generally recommend to use 'git
> send-mail' [1].
> 
> In this specific case, resending the patch as an attachment can also work.

Since I was confused about the state of this patch:
It has been superseded by a patch from Arne, see commit
https://github.com/OpenVPN/openvpn3/commit/53614a0cce7775ba0ae4a43887ee03aa2fa098cc

Also marked it in Patchwork correctly.

Regards,
-- 
  Frank Lichtenheld

