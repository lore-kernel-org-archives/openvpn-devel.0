MIME-Version: 1.0
In-Reply-To: <20180807210155.GJ55859@...1296...>
References: <1516833453-18991-1-git-send-email-selva.nair@...277...>
 <1532486093-24793-1-git-send-email-selva.nair@...277...>
 <20180807185937.GH55859@...1296...>
 <20180807190716.GI55859@...1296...>
 <CAKuzo_i70Ws4U9-VTzVug4aLu11Z5nWsFe2dzCvUDPWEhDXi7w@...278...>
 <20180807210155.GJ55859@...1296...>
From: Selva Nair <selva.nair@...277...>
Date: Tue, 7 Aug 2018 23:16:44 -0400
Message-ID: <CAKuzo_jmA3yAXhy0D36mpXSq2goGmW2WV+pghqi7Y8TLWwJs4Q@...278...>
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

Hi

On Tue, Aug 7, 2018 at 5:01 PM, Gert Doering <gert@...1296...> wrote:
>
>> > in the LinOTP URL - so, it didn't decode it, because the second ':'
>> > was missing (if I put a blank in there, I get pass=mypin%20).
>> >
>> > Is this intentional?  Should it be that way?
>>
>> If you are constructing the SCRV1: line using a custom UI,
>> I would suggest to add the second colon. If using Windows-GUI or running
>> OpenVPN from command line we'll need to fix this one place
>> or the other.
>
> Command line client (git:master/5961250e776194a4, what I happened to
> have lying around), run with a config file that has
>
>   auth-user-pass
>   auth-nocache
>   auth-retry interact
>   static-challenge "token value: " 1
>
> in it, and pressing <return> at the
>
> CHALLENGE: token value: _
>
> prompt.

I cannot reproduce this but the plugin was not able to handle an empty
challenge response. The patch sent to the list should fix that.

With that just pressing <return> at the challenge prompt behaves as
expected (on unpack up->password gets the user input, up->response
stays empty). I haven't tested this using LinOTP, but should work.

Selva

