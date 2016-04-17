MIME-Version: 1.0
In-Reply-To: <1450638773-11376-1-git-send-email-selva.nair@...277...>
References: <1450638773-11376-1-git-send-email-selva.nair@...277...>
From: Steffan Karger <steffan@...1856...>
Date: Sun, 17 Apr 2016 20:59:38 +0200
Message-ID: <CAA1Abx+rbrsaCn1yYpM01tsbgpm-prwH24acsPc4Y9gzXwRnyA@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Support reading the challenge-response
 from console
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
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

On Sun, Dec 20, 2015 at 8:12 PM, Selva Nair <selva.nair@...277...> wrote:
> Trying to keep the footrpint small, this patch adds to the
> convoluted code-flow in get_user_pass_cr(). Cleanup left for later.
> -----8<-----
>
> Currently prompting for a response to static-challenge
> gets skipped when the username and passowrd are read
> from a file. Further, dynamic challenge gets wrongly handled
> as if its a username/password request.
>
> The Fix:
> - Add yet another flag in get_user_pass_cr() to
>   set when prompting of response from console is needed.
> - In receive_auth_failed(), the challenge text received
>   from server _always_ copied to  the auth_challenge
>   buffer: this is needed to trigger prompting from console
>   when required.
> - Also show the challenge text instead of an opaque
>   "Response:" at the prompt.
>
> While at it, also remove the special treatment of authfile ==
> "management" in get_user_pass_cr(). The feature implied by that
> test does not exist.
>
> Tested:
>   - username and optionally password from file, rest from console
>   - the above with a static challenge
>   - the above with a dynamic challenge
>   - all of the above with systemd in place of console
>   - all from management with and without static/dynamic
>     challenge.

Sorry for taking so long to review.

ACK.  These fixes make sense.

-Steffan

