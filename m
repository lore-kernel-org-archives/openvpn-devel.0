MIME-Version: 1.0
In-Reply-To: <CAKuzo_gAZSaVvfSiaZSHC5ESXJ2Q8mEBPq6oV6Wk+AfDidqoXA@...278...>
References: <CAKuzo_jPThhvXTJAtzhqVUVOLPW1VGu6h2jQhVsHicY8P2WRqA@...278...>
 <56fd237f-ba3f-c65d-9831-bf75d4dd139d@...1227...>
 <CAKuzo_gAZSaVvfSiaZSHC5ESXJ2Q8mEBPq6oV6Wk+AfDidqoXA@...278...>
From: "Jonathan K. Bullard" <jkbullard@...277...>
Date: Sat, 2 Dec 2017 07:08:46 -0500
Message-ID: <CAEsd45QPMD57_L-yWHORqumv_-MT6rjC++FVCDRos9F0tTvMvw@...278...>
Subject: Re: [Openvpn-devel] Follow up on sending messages to the GUI
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Selva Nair <selva.nair@...277...>
Cc: Arne Schwabe <arne@...1227...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi,

On Fri, Dec 1, 2017 at 10:58 AM, Selva Nair <selva.nair@...277...> wrote:
>
> Hi,
>
> On Fri, Dec 1, 2017 at 8:53 AM, Arne Schwabe <arne@...1227...> wrote:
>>
>> Am 30.11.2017 um 03:03 schrieb Selva Nair:
>>
>> Cross-posting to users and devel as this may be of interest to both.
>>
>> Hi,
>>
>> I have made a draft implementation of this feature that was discussed in=
 a previous thread. A test executable (GUI only) is in this pre-release:
>>
>> https://github.com/selvanair/openvpn-gui/releases/tag/v11-echo-msg
>>
>> It would be great if anyone can test this out[*].
>>
>> Thanks,
>>
>> Selva
>>
>> [*] Although virtually any text can be sent, some familiarity with openv=
pn config/ccd parsing/quoting and push processing is necessary to get it ri=
ght for non-trivial messages that contain comment characters, commas, new l=
ines etc... Short and simple messages must be easy, though.
>>
>>
>> Could we have some text stating that clients might only display one mess=
age per connect? At the moment you can have multiple "echo msg-notify messa=
ge-title" pushed by the server. I would like to avoid in my client to imple=
ment logic to display multiple messages. If one message allowed the message=
 can become just an Android notification without special logic
>
>
> Yes, we can and probably should document that some clients may only
> display one message. Do you also want to say that some clients may
> interpret msg-window as msg-notify?
>
> Even in case of Windows desktop, I think it may be better to display
> only one message per connection as otherwise it starts to get very
> noisy. At most one message window and one notification.
>
> Jon, do you plan to document the proposed "echo msg" specs in management
> notes or elsewhere?  The single message per connect limitation
> could be specified there.

I'll be happy to try to document the protocol between OpenVPN and the
GUI, including the "msg*" commands and others such as
"forget-passwords", "setenv", etc., which we've discussed. However,
I'm thinking it should be a separate "doc/gui-notes.txt" document.

In a separate document it would be easier to make it clear that it is
describing the protocol between the configuration and the GUIs and not
get lost in the complexity of the management interface itself.

