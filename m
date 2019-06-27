References: <20190627082631.25576-1-wardragon78@...277...>
 <b1a425d0-fdcf-23d6-9ab3-60c76e9133b7@...2181...>
From: Paolo <wardragon78@...277...>
Message-ID: <7fccd4fc-a67f-09c1-79e5-73605bb71e81@...277...>
Date: Thu, 27 Jun 2019 11:48:40 +0200
MIME-Version: 1.0
In-Reply-To: <b1a425d0-fdcf-23d6-9ab3-60c76e9133b7@...2181...>
Content-Language: it-IT
Subject: Re: [Openvpn-devel] [PATCH] Insert client connection data into PAM
 environment
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
To: Antonio Quartulli <a@...2181...>, openvpn-devel@lists.sourceforge.net
Cc: paolo <paolo.cerrito@...2517...>

Hi,

this change is needed to pass remote ip address to pam environment. I
try to explain by an example, so this is the case for us.

I would use pam_recent module to make dynamic ip firewalling. User can
try to login some times, after for example 3 times, pam_recent could
block ip using iptables dynamic rules for about an hour. But pam module
need not only username for logging, but remote ip for firewalling.

This is just an example about the use. But other modules can make other
things using remote ip.




Il 27/06/19 11:07, Antonio Quartulli ha scritto:
> Hi,
>
> On 27/06/2019 10:26, Paolo Cerrito wrote:
>> From: paolo <paolo.cerrito@...2517...>
>>
>> Signed-off-by: Paolo Cerrito <paolo.cerrito@...2517...>
> Why do we need this change?
> What benefit does it give us?
> How can it be used?
>
> IMHO it would be nice to add these pieces of information to the commit
> message (right now it feels .. "empty" ;-) )
>
> Regards,
>
>> ---
>>  src/plugins/auth-pam/auth-pam.c | 19 ++++++++++++++++---
>>  1 file changed, 16 insertions(+), 3 deletions(-)
>>
>> diff --git a/src/plugins/auth-pam/auth-pam.c b/src/plugins/auth-pam/auth=
-pam.c
>> index 88b53204..9d8dfb95 100644
>> --- a/src/plugins/auth-pam/auth-pam.c
>> +++ b/src/plugins/auth-pam/auth-pam.c
>> @@ -115,6 +115,7 @@ struct user_pass {
>>      char password[128];
>>      char common_name[128];
>>      char response[128];
>> +    char remote[128];
>>=20=20
>>      const struct name_value_list *name_value_list;
>>  };
>> @@ -517,13 +518,15 @@ openvpn_plugin_func_v1(openvpn_plugin_handle_t han=
dle, const int type, const cha
>>          const char *username =3D get_env("username", envp);
>>          const char *password =3D get_env("password", envp);
>>          const char *common_name =3D get_env("common_name", envp) ? get_=
env("common_name", envp) : "";
>> +        const char *remote =3D get_env("untrusted_ip", envp) ? get_env(=
"untrusted_ip", envp) : get_env("untrusted_ip6", envp);
>>=20=20
>>          if (username && strlen(username) > 0 && password)
>>          {
>>              if (send_control(context->foreground_fd, COMMAND_VERIFY) =
=3D=3D -1
>>                  || send_string(context->foreground_fd, username) =3D=3D=
 -1
>>                  || send_string(context->foreground_fd, password) =3D=3D=
 -1
>> -                || send_string(context->foreground_fd, common_name) =3D=
=3D -1)
>> +                || send_string(context->foreground_fd, common_name) =3D=
=3D -1
>> +                || send_string(context->foreground_fd, remote) =3D=3D -=
1)
>>              {
>>                  fprintf(stderr, "AUTH-PAM: Error sending auth info to b=
ackground process\n");
>>              }
>> @@ -750,8 +753,16 @@ pam_auth(const char *service, const struct user_pas=
s *up)
>>      status =3D pam_start(service, name_value_list_provided ? NULL : up-=
>username, &conv, &pamh);
>>      if (status =3D=3D PAM_SUCCESS)
>>      {
>> +        /* Set PAM_RHOST environment variable */
>> +        if (*(up->remote))
>> +        {
>> +            status =3D pam_set_item(pamh, PAM_RHOST, up->remote);
>> +        }
>>          /* Call PAM to verify username/password */
>> -        status =3D pam_authenticate(pamh, 0);
>> +        if (status =3D=3D PAM_SUCCESS)
>> +        {
>> +            status =3D pam_authenticate(pamh, 0);
>> +        }
>>          if (status =3D=3D PAM_SUCCESS)
>>          {
>>              status =3D pam_acct_mgmt(pamh, 0);
>> @@ -839,7 +850,8 @@ pam_server(int fd, const char *service, int verb, co=
nst struct name_value_list *
>>              case COMMAND_VERIFY:
>>                  if (recv_string(fd, up.username, sizeof(up.username)) =
=3D=3D -1
>>                      || recv_string(fd, up.password, sizeof(up.password)=
) =3D=3D -1
>> -                    || recv_string(fd, up.common_name, sizeof(up.common=
_name)) =3D=3D -1)
>> +                    || recv_string(fd, up.common_name, sizeof(up.common=
_name)) =3D=3D -1
>> +                    || recv_string(fd, up.remote, sizeof(up.remote)) =
=3D=3D -1)
>>                  {
>>                      fprintf(stderr, "AUTH-PAM: BACKGROUND: read error o=
n command channel: code=3D%d, exiting\n",
>>                              command);
>> @@ -853,6 +865,7 @@ pam_server(int fd, const char *service, int verb, co=
nst struct name_value_list *
>>                              up.username, up.password);
>>  #else
>>                      fprintf(stderr, "AUTH-PAM: BACKGROUND: USER: %s\n",=
 up.username);
>> +                    fprintf(stderr, "AUTH-PAM: BACKGROUND: REMOTE: %s\n=
", up.remote);
>>  #endif
>>                  }
>>=20=20
>>

--=20
-----***********-----
Paolo Cerrito
-----***********-----



