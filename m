MIME-Version: 1.0
References: <1585513970-32658-1-git-send-email-selva.nair@...277...>
 <1585513970-32658-2-git-send-email-selva.nair@...277...>
 <CAEsd45RgM7Uh55jKS=Sqz_Wy+0r_j649WvE1w6ki7V4oMjt+UQ@...278...>
 <CAKuzo_hp5ojMrr0KmnHVR335uJ58QTveuqC5C9Brqv-SUq_nTA@...278...>
 <20200330060754.GU1431@...1296...>
 <CAKuzo_gXnxLCFLpQB7Rsg+2VNP4U0jUTAjKLL_4A5nx9rdkBZw@...278...>
 <CAEsd45R3571EMBik_KauVWyfwyjS2oMKkxnbX5hj5UkniS4n3Q@...278...>
 <CAKuzo_jeYoYVMp+BkJWfdEeQ8gsm2W3RenV5UcszYxt-26p_Hg@...278...>
In-Reply-To: <CAKuzo_jeYoYVMp+BkJWfdEeQ8gsm2W3RenV5UcszYxt-26p_Hg@...278...>
From: "Jonathan K. Bullard" <jkbullard@...277...>
Date: Mon, 30 Mar 2020 12:42:15 -0400
Message-ID: <CAEsd45QcswiTmts2TWQgnMSsDBcAMchnxwSNA7LTWiNwz=4J-Q@...278...>
Subject: Re: [Openvpn-devel] [PATCH 2/2] When auth-user-pass file has no
 password, query the management
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
Cc: Gert Doering <gert@...1296...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

On Mon, Mar 30, 2020 at 12:30 PM Selva Nair <selva.nair@...277...> wrote:

> That is, if management-query-passwords is enabled and auth file is
> missing password, query the management, not on console irrespective
> of other options and OS. If that's acceptable, I'll submit a v2.

That's fine with me (and Tunnelblick), thanks.

Best regards,

Jon Bullard

