MIME-Version: 1.0
In-Reply-To: <CAOazyz2oNmWMAhiqZ-RUaJXG+pXe-EviEX6ajRqi_T4m4kZ-Ew@...278...>
References: <4F6D06C5.3030408@...1114...>
	<1332575918-3384-4-git-send-email-alon.barlev@...277...>
	<4F703565.3070008@...1114...>
	<CAOazyz2Zt98TKwfr1zyALc-6fgOeDEgCW4Br4rOM0PT290_kFw@...278...>
	<4F704909.2050001@...1114...>
	<CAOazyz2oNmWMAhiqZ-RUaJXG+pXe-EviEX6ajRqi_T4m4kZ-Ew@...278...>
Date: Mon, 26 Mar 2012 12:48:58 +0200
Message-ID: <CAOazyz0USX5V3ZU0nDn6wJLnEWDymzHW=Vis6dYbC52Kj0Z7Hg@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH 3/6] tree: ChangeLog: add ident attribute
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: David Sommerseth <openvpn.list@...1114...>, "openvpn-devel@lists.sourceforge.net" <Openvpn-devel@lists.sourceforge.net>

On Mon, Mar 26, 2012 at 12:48 PM, Alon Bar-Lev <alon.barlev@...277...> wrot=
e:
> On Mon, Mar 26, 2012 at 12:46 PM, David Sommerseth
> <openvpn.list@...1114...> wrote:
>> -----BEGIN PGP SIGNED MESSAGE-----
>> Hash: SHA1
>>
>> On 26/03/12 12:25, Alon Bar-Lev wrote:
>>> On Mon, Mar 26, 2012 at 11:22 AM, David Sommerseth
>>> <openvpn.list@...1114...> wrote:
>>>>
>>>> -----BEGIN PGP SIGNED MESSAGE----- Hash: SHA1
>>>>
>>>> On 24/03/12 08:58, Alon Bar-Lev wrote:
>>>>> --- .gitattributes | =C2=A0 =C2=A01 + ChangeLog =C2=A0 =C2=A0 =C2=A0|=
 =C2=A0 =C2=A02 ++ 2 files
>>>>> changed, 3 insertions(+), 0 deletions(-) create mode 100644
>>>>> .gitattributes
>>>>>
>>>>> diff --git a/.gitattributes b/.gitattributes new file mode 100644
>>>>> index 0000000..9cf9e1f --- /dev/null +++ b/.gitattributes @@ -0,0
>>>>> +1 @@ +ChangeLog ident diff --git a/ChangeLog b/ChangeLog index
>>>>> d498344..d7cc77c 100644 --- a/ChangeLog +++ b/ChangeLog @@ -1,6
>>>>> +1,8 @@ OpenVPN Change Log Copyright (C) 2002-2011 OpenVPN
>>>>> Technologies, Inc. <sales@...515...>
>>>>>
>>>>> +$Id$ +
>>>>
>>>> What is the purpose of this change?
>>>
>>> Oh... I remembered that this was in tree long ago[1], thought that it
>>> was dropped out when moving to git not intentionally.
>>>
>>> If otherwise, ignore this patch.
>>>
>>> It is nice to see the revision of the changelog as most probably it
>>> is the last revision before release. So if one forget to tag or
>>> something the data is available.
>>
>> Yeah, I agree that such markers may make sense in some cases. =C2=A0But =
with
>> git, the closest you can get to make this useful is to use .gitattributes
>> which can be told to update this with the blob sha reference of the
>> ChangeLog file. =C2=A0But that's not much helpful in the end. =C2=A0So I=
 rather
>> suggest we drop this one.
>>
>> There's a rather sane discussion here on this topic:
>> <http://stackoverflow.com/questions/384108/moving-from-cvs-to-git-id-equ=
ivalent>
>>
>> Currently, I update ChangeLog when tagging the tree when we're about to
>> do a new release. =C2=A0I use the output of git shortlog as a summary. =
=C2=A0This
>> information is also available in the message blob of signed tags as well.
>> =C2=A0This way, the ChangeLog is always updated with all committed chang=
es,
>> and for a more verbose changelog, you have 'git log' (or the git web UI).
>
> OK.
> Drop it.
>
> Alon.

