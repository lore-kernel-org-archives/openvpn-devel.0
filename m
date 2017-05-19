MIME-Version: 1.0
Sender: emmanueldeloget53@...277...
In-Reply-To: <20170518204910.GT97029@...1296...>
References: <cover.1487368114.git.logout@...260...>
	<e5e93420586b24b7df5b2f5ac2df02ccec5ffdb1.1487368114.git.logout@...260...>
	<66d4f562-4786-f3fd-a6ae-27ebe10abf59@...1856...>
	<20170302212621.GE93896@...1296...>
	<735306eb-5dc4-19b0-75ad-2141fb2905b2@...1856...>
	<72797fe3-23f7-8b10-19df-29cc4f31ef98@...2080...>
	<CAKh=nwFF-Lc-Q52QCoh0WgP3g0gr0P7_i9CqwcpC2mDzGCi8sw@...278...>
	<20170518204910.GT97029@...1296...>
From: Emmanuel Deloget <logout@...260...>
Date: Fri, 19 May 2017 12:37:17 +0200
Message-ID: <CAKh=nwFot6GZiv1cs2-X8kL0UNS6r8BGsNQ2RtC+0eyiJRMZtA@...278...>
Subject: Re: [Openvpn-devel] OpenSSL 1.1 patch set - status?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

Hi Gert,


On Thu, May 18, 2017 at 10:49 PM, Gert Doering <gert@...1296...> wrote:
>
> Hi Emmanuel,
>
> On Mon, Mar 27, 2017 at 05:49:48PM +0200, Emmanuel Deloget wrote:
> > I'll post my new patches as soon as I get over every issues
> > that have been talked on the ML (is that even a valid
> > sentence?)
>
> I'm wondering where this got stuck - are you waiting for us to move
> forward (like, missing review of parts of the patch set), or are we
> waiting for you, and you've been busy?

Problem is that I'm working in a more-than-full-time manner on
way-too-many-other subjects :)

> We didn't really follow up on this from our end since the CVEs and
> 2.4.2 got in the way - but I think now would be a good time to move
> ahead with this...

I have a git tree out there that I have not fully tested yet. It
compiles OK with OpenSSL 0.9.8, 1.0.0, 1.0.1, 1.0.2 and 1.1.0 but I
haven't checked the behavior.

The main difference with the previous version of the patch is the way
the certificate purpose is checked.

A) we do a fairly full check of the purpose using
X509_check_purpose(). This check is harder that the previous version

B) if that fails, we check for the certificate purpose using a lighter
method which is strictly equivalent to what was done before (it uses
X509_get_ext_d2i() to fetch the certificate type from within the
certificate).

The branch is available for viewing on github at
https://github.com/emmanuel-deloget/openvpn/tree/openssl-1.1-v6.

The followup emails contains the 7 patches which are needed to finish the work.

BR,

-- Emmanuel Deloget

