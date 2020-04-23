MIME-Version: 1.0
References: <1532486093-24793-1-git-send-email-selva.nair@...277...>
 <201808071901.w77J1bEd015348@...2054...>
In-Reply-To: <201808071901.w77J1bEd015348@...2054...>
From: Selva Nair <selva.nair@...277...>
Date: Thu, 23 Apr 2020 10:02:10 -0400
Message-ID: <CAKuzo_iwqCQ-hQo=uc1_NTa845HBWEAMr98QvVzULQFuLN3SYw@...278...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Parse static challenge
 response in auth-pam plugin
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
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

On Tue, Aug 7, 2018 at 3:01 PM Gert Doering <gert@...1296...> wrote:
>
> Your patch has been applied to the master branch.
>
> (I'm a bit undecided about release/2.4 - this is in "new feature!" land,
> and all the challenge stuff is "master" territory.  OTOH, it's not openvpn
> main code, and the code is sane enough - so if folks think it should be
> in release/2.4, tell me)
>
> commit 7369d01bf360bcfa02f26c05b86dde5496d120f6 (master)

I failed to respond to this that time.

Although this is a new feature, I too think its safe and useful to
include this in 2.4.
If we do, we'll need this one (commit
7369d01bf360bcfa02f26c05b86dde5496d120f6) and the followup one
7a8109023f4c345fe12f23421c5fa7e88e1ea85b

Both should cherry-pick without conflicts.

See also Trac #1275 https://community.openvpn.net/openvpn/ticket/1275

Thanks,

Selva

