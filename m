MIME-Version: 1.0
In-Reply-To: <55464DBE.4010203@...1856...>
References: <CAEsd45S8+hwK9mB53mVBLO-1NSJp7YE3tx53Am83pzDL+tr8GQ@...278...>
	<55464DBE.4010203@...1856...>
From: "Jonathan K. Bullard" <jkbullard@...277...>
Date: Mon, 4 May 2015 09:26:49 -0400
Message-ID: <CAEsd45RoxhHiXGTAQwaPHHPnqfMk=iHjkoJOzeU_WaSU72MKXQ@...278...>
Subject: Re: [Openvpn-devel] OpenVPN argument parsing of most options
 ignores "extra" parameters
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
To: Steffan Karger <steffan@...1856...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

On Sun, May 3, 2015 at 12:33 PM, Steffan Karger <steffan@...1856...> wrote:
> On 17-04-15 11:28, Jonathan K. Bullard wrote:
> > I would like to propose a patch which complains if OpenVPN options
> > include parameters that are not expected.
>
> I agree that silently ignoring extra parameters is not nice. However, I
> think that breaking configs after they have worked for many years might
> result in too many unpleasant surprises for our users. How would you
> feel about just issuing a warning for ignored extra parameters?

Thanks for your comment. It's a difficult balance.

In my opinion a warning is not sufficient: if a configuration has an
extra parameter, the user probably **thinks** that the parameter is
doing something. In that situation, I would personally would rather
have an unpleasant surprise than continue in ignorance. If I have a
configuration that has worked for many years I might be more likely to
not notice one warning among all the output in a typical log at the
default "verb 3" setting.

The "fix" if a config fails is very simple: remove the extra parameter
or insert a line break if one is missing. You can then connect, and
OpenVPN's behavior will not have changed except that if a line break
was inserted then the previously ignored option will be used. If the
parameter was supposed to do something important, then more thought
might be required, but in that case, it is probably even **more**
important that the configuration breaks.

Perhaps it could go into OpenVPN 2.4 but not 2.3? As I understand it,
2.3 is gets security and bug fixes, so many people probably don't test
it as thoroughly as a new release; some probably won't test it at all
-- those are the ones that you are presumably worried about. When 2.4
is released, most people will test it at least cursorily before
deploying it. If extra parameters cause a failure, it will be
immediately obvious and can be fixed easily.

Although usually ignoring extra parameters would not cause security
problems, to the extent they do, the concept of OpenVPN being "secure
by default" is jeopardized by not causing an error. Something like
ignoring a "--redirect-gateway def1" -- which would cause traffic to
be "leaked" outside of the VPN -- could be considered a security risk.

