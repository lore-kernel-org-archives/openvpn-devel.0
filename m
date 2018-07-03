MIME-Version: 1.0
In-Reply-To: <1530581086-7825-1-git-send-email-selva.nair@...277...>
References: <1530581086-7825-1-git-send-email-selva.nair@...277...>
From: "Jonathan K. Bullard" <jkbullard@...277...>
Date: Mon, 2 Jul 2018 23:13:01 -0400
Message-ID: <CAEsd45SC3aXgJYX33gFyF53A3njcbokK8ho_G7-6VDVG84zNfA@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Make up/down script errors not FATAL
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

Hi.

On Mon, Jul 2, 2018 at 9:24 PM, <selva.nair@...277...> wrote:
>
> From: Selva Nair <selva.nair@...277...>
>
> Instead log only a warning.
>
> This helps user interfaces enforce a safer script-security setting
> without causing a FATAL error.


Can you expand on that? What "safer script secuity settings' do you
have in mind? Tunnelblick (and I think all Linux) use script-security
2 to allow for up/down scripts that implement DNS and other settings.

My initial reaction is that I'd rather a problem in the up/down
scripts generates a fatal error, so if there's a problem in the
Tunnelblick scripts somebody will report it. In my experience, almost
nobody pays attention to warnings, and mostly, those who do are
worried about warning that don't matter.

Best regards,

Jon Bullard

