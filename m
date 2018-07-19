MIME-Version: 1.0
In-Reply-To: <CAKuzo_hhoa_3xs0NSt7A7o-9WErqZEp+uvGv2XQi0FmJ10H9jw@...278...>
References: <CAEsd45Rd+5_NTeQ_E1C9wps89GWU6OfxQ5CdEFiN_HCO0=xaAQ@...278...>
 <CAKuzo_in_bBm1Y1rwU3rhFfuUP8o7j9iQH9vyjk9myT42tpBSg@...278...>
 <CAEsd45Tqb4nCQYe9_CKwr6YKdW4BoF3B-V=iQU=KXPnYDu8GJQ@...278...>
 <CAKuzo_hhoa_3xs0NSt7A7o-9WErqZEp+uvGv2XQi0FmJ10H9jw@...278...>
From: "Jonathan K. Bullard" <jkbullard@...277...>
Date: Thu, 19 Jul 2018 11:43:17 -0400
Message-ID: <CAEsd45STfqNvTKFTcpJ8nsy0nfndfQHJ7dTD8iSRJFGQ5aE3Hg@...278...>
Subject: Re: [Openvpn-devel] Dynamic challenge/response questions
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
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Thank you, Selva! (Now all I need to do is get it working!)

Best regards,

Jon


On Thu, Jul 19, 2018 at 11:39 AM, Selva Nair <selva.nair@...277...> wrote:
> Hi,
>
> On Thu, Jul 19, 2018 at 10:48 AM, Jonathan K. Bullard
> <jkbullard@...277...> wrote:
>> Thank you very much, Selva.
>>
>> On Wed, Jul 18, 2018 at 10:48 PM, Selva Nair <selva.nair@...277...> wrot=
e:
>> <snip>
>>> There are two messages involved:
>>>
>>> 1. First comes the fake auth failure message which contains the
>>> challenge string. The format of this is as you have quoted above. The
>>> single quoted string between the square brackets is what is actually
>>> sent by the server. This should be parsed as
>>>
>>> CRV1:flags:state_id:base64_username:challenge
>>> (note that there is no colon at the end)
>>>
>>> So in the above example
>>> flags =3D R,E
>>> state_id =3D Om01u7Fh4LrGBS7uh0SWmzwabUiGiW6I
>>> base64_username =3D Y3Ixh
>>> challenge =3D Please enter token PIN:
>>>
>>> In this case the last colon is a part of the challenge as its not a
>>> part of the protocol.
>>>
>>> As the daemon thinks auth failed, this will trigger a restart. On
>>> restart the client openvpn daemon will prompt for username password as
>>> usual. So
>>>
>>> 2. The usual auth prompt comes as
>>>
>>>>PASSWORD:Need 'Auth' username
>>>>PASSWORD:Need 'Auth' password
>>>
>>> The GUI should remember that this prompt follows the
>>> verification-failure message that contained a CRV1 challenge and be
>>> ready to respond accordingly. And should be responded to in the same
>>> format as usual user-auth response but this time with the decoded
>>> username as username and the specially formatted challenge response
>>> (see below) as the password.
>>
>> I  _completely_  misunderstood how this works! I apologize for being so =
dense.
>>
>> Can you confirm that the following is correct?
>>
>>  1. When the GUI gets a ">PASSWORD:Verification Failed: 'Auth'
>> ['CRV1:=E2=80=A6" message, it just stores the info.
>>
>>  2. Each time after 1., when the GUI gets a ">PASSWORD:Need 'Auth'
>> username" request, it responds with the decoded username from the
>> stored info.
>>
>>  3. Each time after 1., when the GUI gets a ">PASSWORD:Need 'Auth'
>> password" request, it asks the user for a password (using the prompt
>> from the info) and sends that back with the "state_id" from the stored
>> info and formatted as described.
>>
>
> Yes, yes and partially yes :) -- instead of each time, make it the "first=
 time".
> (see below)
>
>>  4. Any later ">PASSWORD:Verification Failed: 'Auth' ['CRV1:=E2=80=A6"
>> messages overwrite the old info the GUI stored.
>>
>
> Yes.
>
>> Or do 2. and 3. only happen once, and after that responses to
>> ">PASSWORD:Need 'Auth' username" and ">PASSWORD:Need 'Auth' password"
>> should revert back to the normal behavior until another
>> ">PASSWORD:Verification Failed: 'Auth' ['CRV1:=E2=80=A6" message is rece=
ived?
>
> One should revert back to the usual auth-user-pass state after
> responding to the challenge. So, save the challenge and associated
> info on receiving it and clear it on using it. Then the logic would
> be: if a saved challenge is present use it to "construct" the response
> for 'Auth' requests, else use the usual auth-user-pass procedure.
>
> Selva

