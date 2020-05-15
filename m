References: <20191109151306.18597-1-arne@...1227...>
 <20191109151306.18597-4-arne@...1227...>
 <6b1140c9-912f-bb98-506d-e0b061f016ba@...2080...>
 <498473eb-46e4-6d86-a1e8-2d73bfa7a594@...2080...>
From: Jan Just Keijser <janjust@...1147...>
Message-ID: <bfe1b4b4-eda5-4bb8-b53e-15b306731b70@...1147...>
Date: Fri, 15 May 2020 17:54:39 +0200
MIME-Version: 1.0
In-Reply-To: <498473eb-46e4-6d86-a1e8-2d73bfa7a594@...2080...>
Content-Language: nl-NL
Subject: Re: [Openvpn-devel] [PATCH v2 4/5] Implement sending SSO challenge
 to clients
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
To: David Sommerseth <openvpn@...2080...>, Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

On 15/05/20 17:40, David Sommerseth wrote:
> On 15/05/2020 17:36, David Sommerseth wrote:
>> On 09/11/2019 16:13, Arne Schwabe wrote:
>>> This implements sending AUTH_PENDING and INFO_PRE messages to clients
>>> that indicate that the clients should be continue authentication with
>>> a second factor. This can currently be out of band (openurl) or a normal
>>> challenge/response 2FA like TOTP (CR_TEXT).
>> Can we settle on a single CR_TEXT vs CRTEXT terminology?  The 3/5 patch used
>> crtext in the documentation but cr_text in the commit message.
>>
>>> Signed-off-by: Arne Schwabe <arne@...1227...>
>>> ---
>>>   doc/management-notes.txt | 26 +++++++++++++++++++++++
>>>   src/openvpn/manage.c     | 46 ++++++++++++++++++++++++++++++++++++++++
>>>   src/openvpn/manage.h     |  3 +++
>>>   src/openvpn/multi.c      | 19 +++++++++++++++++
>>>   src/openvpn/push.c       | 24 +++++++++++++++++++++
>>>   src/openvpn/push.h       |  2 ++
>>>   6 files changed, 120 insertions(+)
>>>
>>> diff --git a/doc/management-notes.txt b/doc/management-notes.txt
>>> index e380ca2b..4b405a9b 100644
>>> --- a/doc/management-notes.txt
>>> +++ b/doc/management-notes.txt
>>> @@ -592,6 +592,32 @@ interface to approve client connections.
>>>   CID,KID -- client ID and Key ID.  See documentation for ">CLIENT:"
>>>   notification for more info.
>>>   
>>> +COMMAND -- client-sso-auth  (OpenVPN 2.5 or higher)
>>> +----------------------------------------------------
>>> +
>>> +Instruct OpenVPN server to send AUTH_PENDING and INFO_PRE signal
>>> +a single sign on url to the client.
>>> +
>>> +    client-sso-auth {CID} {EXTRA}
>> I think we should use a different naming for this than 'sso'.  This is not
>> tied to only SSO (Single Sign-On).  What about:
>>
>>   - client-extended-auth
>>   - client-external-auth
>>   - client-ext-auth
>>   - client-additional-auth
>>   - client-xauth
> Another alternative popped up in my head, as CR/Challenge-Response is used a
> lot in this context .... client-cr-auth  .... but all of them are just
> suggestions to avoid the 'sso' reference.
>
>> As long as the name is quite generic, I'm fine with most alternatives.  But it
>> should be very generic.  We have so many alternative auth methods these days:
>> Yubico OTP [1], TOTP/HOTP, FIDO/U2F, SAML, OAuth, Kerberos/GSSAPI, etc ...
>>
>> [1] <https://developers.yubico.com/OTP/OTPs_Explained.html>

+1 on avoiding the 'sso' reference  - this has nothing to do with 
SSO/SAML/OAuth/OpenID etc etc and I think it would be unwise to suggest 
that OpenVPN does something like "that" kind of SSO auth. Before we know 
it users will start asking how they can link their Hotmail, FB or Google 
account to their OpenVPN config....

JM2CW,

JJK




