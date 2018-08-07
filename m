MIME-Version: 1.0
In-Reply-To: <20180807190716.GI55859@...1296...>
References: <1516833453-18991-1-git-send-email-selva.nair@...277...>
 <1532486093-24793-1-git-send-email-selva.nair@...277...>
 <20180807185937.GH55859@...1296...>
 <20180807190716.GI55859@...1296...>
From: Selva Nair <selva.nair@...277...>
Date: Tue, 7 Aug 2018 15:38:43 -0400
Message-ID: <CAKuzo_i70Ws4U9-VTzVug4aLu11Z5nWsFe2dzCvUDPWEhDXi7w@...278...>
Subject: Re: [Openvpn-devel] [PATCH v3] Parse static challenge response in
 auth-pam plugin
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

On Tue, Aug 7, 2018 at 3:07 PM, Gert Doering <gert@...1296...> wrote:
> Hi,
>
> On Tue, Aug 07, 2018 at 08:59:37PM +0200, Gert Doering wrote:
>> > v2: Depends on the base64 export patch
>> > v3: match password string with "SCRV1:" instead of "SCRV1"
>> > (pointed out by Joe Bell <joeaintexas@...277...>)
>>
>> Nicely works and does what it says on the lid.  So...
>
> Talking to myself a lot, lately...
>
> Found an interesting caveat which should be addressed, I think.
>
> Our system (LinOTP) knows "PIN+OTP" or "PIN" as valid input, the
> latter leading to "send me a token by SMS/e-mail/...".
>
> If I press return at the challenge prompt, it seems the SCRV1: string
> is not formed the way the plugin wants it, and I end up with
>
>   pass=SCRV1%3AMTE5NQ%3D%3D

How to format this if response is empty is not clearly documented
but my impression was that the second ':' (%3A) is required.

management-notes.txt specifies the format as

password "Auth" "SCRV1:<BASE64_PASSWORD>:<BASE64_RESPONSE>"

The Windows GUI prints it using a template "SCRV1:%s:%s", so the second
colon will be present if response is empty -- if that's not happening
I would consider
that a bug in the GUI.

When password is read from stdin, its formatted as (from misc.c line 358)

buf_printf(&packed_resp, "SCRV1:%s:%s", pw64, resp64);

So that should also contain the second colon.

>
> in the LinOTP URL - so, it didn't decode it, because the second ':'
> was missing (if I put a blank in there, I get pass=mypin%20).
>
> Is this intentional?  Should it be that way?

If you are constructing the SCRV1: line using a custom UI,
I would suggest to add the second colon. If using Windows-GUI or running
OpenVPN from command line we'll need to fix this one place
or the other.

Selva

