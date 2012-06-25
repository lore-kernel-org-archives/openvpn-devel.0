MIME-Version: 1.0
Date: Mon, 25 Jun 2012 14:54:00 +0300
From: Adrien Bustany <adrien@...1716...>
In-Reply-To: <4FE447BF.1040004@...515...>
References: <1336462203-20226-1-git-send-email-adrien@...1716...>
	<1336462203-20226-2-git-send-email-adrien@...1716...>
	<4FE447BF.1040004@...515...>
Message-ID: <dce8517881cd57596b704ba7bd9489fc@...1717...>
Subject: Re: [Openvpn-devel]
 =?utf-8?q?=5BPATCH=5D_management=3A_Don=27t_requi?=
 =?utf-8?q?re_DAF=5FINITIAL=5FAUTH_to_send_ADDRESS/DISCONNECT_messages?=
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
To: =?UTF-8?Q?Samuli_Sepp=C3=A4nen?= <samuli@...515...>
Cc: Adrien Bustany <adrien.bustany@...1719...>, openvpn-devel@lists.sourceforge.net

Le 2012-06-22 13:23, Samuli Sepp=C3=A4nen a =C3=A9crit=C2=A0:
>> From: Adrien Bustany <adrien.bustany@...1719...>
>>
>> DAF_INITIAL_AUTH will only be set if a password was needed for=20
>> client
>> authentication. This means that for password-less certificate
>> authentication, no DISCONNECT/ADDRESS messages would be sent.
>> ---
>>  src/openvpn/manage.c |    4 ++--
>>  1 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
>> index 1dddd41..4148f7c 100644
>> --- a/src/openvpn/manage.c
>> +++ b/src/openvpn/manage.c
>> @@ -2474,7 +2474,7 @@ management_notify_client_close (struct=20
>> management *management,
>>  				struct man_def_auth_context *mdac,
>>  				const struct env_set *es)
>>  {
>> -  if ((mdac->flags & DAF_INITIAL_AUTH) && !(mdac->flags &=20
>> DAF_CONNECTION_CLOSED))
>> +  if (!(mdac->flags & DAF_CONNECTION_CLOSED))
>>      {
>>        msg (M_CLIENT, ">CLIENT:DISCONNECT,%lu", mdac->cid);
>>        man_output_env (es, true,=20
>> management->connection.env_filter_level, "CLIENT");
>> @@ -2489,7 +2489,7 @@ management_learn_addr (struct management=20
>> *management,
>>  		       const bool primary)
>>  {
>>    struct gc_arena gc =3D gc_new ();
>> -  if ((mdac->flags & DAF_INITIAL_AUTH) && !(mdac->flags &=20
>> DAF_CONNECTION_CLOSED))
>> +  if (!(mdac->flags & DAF_CONNECTION_CLOSED))
>>      {
>>        msg (M_CLIENT, ">CLIENT:ADDRESS,%lu,%s,%d",
>>  	   mdac->cid,
> Hi Adrien,
>
> We discussed this patch in our IRC meeting yesterday, and couple of
> questions popped up... First, what is the benefit of this patch? Is=20
> it
> just to see if the clients connect even if they're not using password
> authentication? Second, what's the impact on existing management
> interface clients, i.e. can this patch break compatibility?
>
> Best regards,

Hi Samuli

thanks for reviewing the patch. What this patch does is as you said=20
enable a program monitoring the management interface of an openvpn=20
daemon to get connection events for clients authenticating with a=20
password-less TLS certificate. We found it useful, since in our case=20
that's what clients use and we still wanted to monitor who was connected=20
and with what IP.
I can't vouch at a 100% for backwards compatibility, mainly since I=20
don't have a windows machine to test the existing management interface.=20
Is there another way to test that? Any unit tests?

Cheers

Adrien

