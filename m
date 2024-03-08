Date: Fri, 8 Mar 2024 13:10:27 +0100
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <ZesAM4x4qkL01WzM@...2685...>
References: <CAEeEfvzkhp_FQ8cnOZcASiVbDN8=+Gw_2sV5SNonL5x7OYb1jA@...278...>
 <892bc3fa-b752-b959-1ea4-19b106c0915c@...1227...>
 <CAEeEfvyw2AKiKV1DW2mPA8C332pK7nroA9=BtpqEND2TPGmFog@...278...>
 <ffffcce0-1c0b-cd4e-95c5-b17d523cbf30@...2108...>
 <ZehuqZx1dir/Q8p2@...2685...>
 <CAEeEfvz7gZzhW0JDAE96H_C_2UGa_=Roa6nyWtn1AxQOME2Ysg@...278...>
MIME-Version: 1.0
In-Reply-To: <CAEeEfvz7gZzhW0JDAE96H_C_2UGa_=Roa6nyWtn1AxQOME2Ysg@...278...>
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
To: Merten Fermont <merten.fermont@...277...>
Cc: David Sommerseth <dazo+openvpn@...2108...>, openvpn-devel@lists.sourceforge.net

On Fri, Mar 08, 2024 at 10:47:27AM +0100, Merten Fermont wrote:
> Hi Frank,
> 
> Arne has indeed applied a fix based on this patch.
> 
> However, it looks like the case from this issue is not completely solved:
> https://github.com/OpenVPN/openvpn3/issues/277
> If you have options "client" and "pull" but no "tls-client" in the config,
> the "pull" option will not be touched.

True, due to short-circuit logic. I will prepare a fix.

Regards,
-- 
  Frank Lichtenheld

