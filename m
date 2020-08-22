Content-Type: multipart/alternative;
 boundary=Apple-Mail-9D0E0245-5F2D-4BBB-8E35-22FA072A63AC
Mime-Version: 1.0 (1.0)
From: Marvin Adeff <volleynbike@...277...>
In-Reply-To: <CAKuzo_hm24jvC6C=fLO_Rzx0xu5rb_5LdDEwCoi5MSQPdGtqaw@...278...>
Date: Fri, 21 Aug 2020 19:37:27 -0700
Content-Transfer-Encoding: 7bit
Message-Id: <5BBA3889-D486-40CA-A651-78F19FD1463B@...277...>
References: <20200819070746.197-1-lstipakov@...277...>
 <CAKuzo_hm24jvC6C=fLO_Rzx0xu5rb_5LdDEwCoi5MSQPdGtqaw@...278...>
Subject: Re: [Openvpn-devel] [PATCH] tun.c: enable using wintun driver under
 SYSTEM
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: Lev Stipakov <lstipakov@...277...>, Lev Stipakov <lev@...515...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--Apple-Mail-9D0E0245-5F2D-4BBB-8E35-22FA072A63AC
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,

When will this be available as an installable (beta) msi?

Marvin=20

> On Aug 21, 2020, at 2:13 PM, Selva Nair <selva.nair@...277...> wrote:
>=20
> Hi,
>=20
>> On Wed, Aug 19, 2020 at 3:08 AM Lev Stipakov <lstipakov@...277...> wrote:
>> From: Lev Stipakov <lev@...515...>
>>=20
>> Commit 6d19775a468 has removed SYSTEM elevation hack,
>> but introduced regression - inability to use wintun without interactive =
service.
>>=20
>> Proceed with ring buffers registration even if iservice is unavailable a=
nd display
>> relevant error message.
>>=20
>> Trac #1318
>>=20
>> Signed-off-by: Lev Stipakov <lev@...515...>
>> ---
>>  src/openvpn/tun.c | 30 +++++++++++++++++++++++++-----
>>  1 file changed, 25 insertions(+), 5 deletions(-)
>>=20
>> diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
>> index 30454454..62557364 100644
>> --- a/src/openvpn/tun.c
>> +++ b/src/openvpn/tun.c
>> @@ -6158,12 +6158,32 @@ wintun_register_ring_buffer(struct tuntap *tt, c=
onst char *device_guid)
>>      }
>>      else
>>      {
>> -        msg(M_FATAL, "ERROR:  Wintun requires SYSTEM privileges and the=
refore "
>> -                     "should be used with interactive service. If you w=
ant to "
>> -                     "use openvpn from command line, you need to do SYS=
TEM "
>> -                     "elevation yourself (for example with psexec).");
>> -    }
>> +        if (!register_ring_buffers(tt->hand,
>> +                                   tt->wintun_send_ring,
>> +                                   tt->wintun_receive_ring,
>> +                                   tt->rw_handle.read,
>> +                                   tt->rw_handle.write))
>> +        {
>> +            switch (GetLastError())
>> +            {
>> +                case ERROR_ACCESS_DENIED:
>> +                    msg(M_FATAL, "ERROR:  Wintun requires SYSTEM privil=
eges and therefore "
>> +                                 "should be used with interactive servi=
ce. If you want to "
>> +                                 "use openvpn from command line, you ne=
ed to do SYSTEM "
>> +                                 "elevation yourself (for example with =
psexec).");
>> +                    break;
>> +
>> +                case ERROR_ALREADY_INITIALIZED:
>> +                    msg(M_NONFATAL, "Adapter %s is already in use", dev=
ice_guid);
>> +                    break;
>>=20
>> +                default:
>> +                    msg(M_NONFATAL | M_ERRNO, "Failed to register ring =
buffers");
>> +            }
>> +            ret =3D false;
>> +        }
>> +
>> +    }
>>      return ret;
>>  }
>=20
> Looks good and running as SYSTEM works now as expected. Tested on 64 bit =
Windows 10.
>=20
> Acked-by: selva.nair@...277...=20
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--Apple-Mail-9D0E0245-5F2D-4BBB-8E35-22FA072A63AC
Content-Type: text/html;
	charset=utf-8
Content-Transfer-Encoding: 7bit

<html><head><meta http-equiv="content-type" content="text/html; charset=utf-8"></head><body dir="auto">Hi,<div><br></div><div>When will this be available as an installable (beta) msi?<br><br><div dir="ltr">Marvin&nbsp;</div><div dir="ltr"><br>On Aug 21, 2020, at 2:13 PM, Selva Nair &lt;<a href="mailto:selva.nair@...277...">selva.nair@...277...</a>&gt; wrote:<br><br></div><blockquote type="cite"><div dir="ltr"><div dir="ltr"><div>Hi,</div><br><div class="gmail_quote"><div dir="ltr" class="gmail_attr">On Wed, Aug 19, 2020 at 3:08 AM Lev Stipakov &lt;<a href="mailto:lstipakov@...277...">lstipakov@...277...</a>&gt; wrote:<br></div><blockquote class="gmail_quote" style="margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">From: Lev Stipakov &lt;<a href="mailto:lev@...515..." target="_blank">lev@...515...</a>&gt;<br>
<br>
Commit 6d19775a468 has removed SYSTEM elevation hack,<br>
but introduced regression - inability to use wintun without interactive service.<br>
<br>
Proceed with ring buffers registration even if iservice is unavailable and display<br>
relevant error message.<br>
<br>
Trac #1318<br>
<br>
Signed-off-by: Lev Stipakov &lt;<a href="mailto:lev@...515..." target="_blank">lev@...515...</a>&gt;<br>
---<br>
&nbsp;src/openvpn/tun.c | 30 +++++++++++++++++++++++++-----<br>
&nbsp;1 file changed, 25 insertions(+), 5 deletions(-)<br>
<br>
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c<br>
index 30454454..62557364 100644<br>
--- a/src/openvpn/tun.c<br>
+++ b/src/openvpn/tun.c<br>
@@ -6158,12 +6158,32 @@ wintun_register_ring_buffer(struct tuntap *tt, const char *device_guid)<br>
&nbsp; &nbsp; &nbsp;}<br>
&nbsp; &nbsp; &nbsp;else<br>
&nbsp; &nbsp; &nbsp;{<br>
-&nbsp; &nbsp; &nbsp; &nbsp; msg(M_FATAL, "ERROR:&nbsp; Wintun requires SYSTEM privileges and therefore "<br>
-&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;"should be used with interactive service. If you want to "<br>
-&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;"use openvpn from command line, you need to do SYSTEM "<br>
-&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;"elevation yourself (for example with psexec).");<br>
-&nbsp; &nbsp; }<br>
+&nbsp; &nbsp; &nbsp; &nbsp; if (!register_ring_buffers(tt-&gt;hand,<br>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;tt-&gt;wintun_send_ring,<br>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;tt-&gt;wintun_receive_ring,<br>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;tt-&gt;rw_handle.read,<br>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;tt-&gt;rw_handle.write))<br>
+&nbsp; &nbsp; &nbsp; &nbsp; {<br>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; switch (GetLastError())<br>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; {<br>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; case ERROR_ACCESS_DENIED:<br>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; msg(M_FATAL, "ERROR:&nbsp; Wintun requires SYSTEM privileges and therefore "<br>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;"should be used with interactive service. If you want to "<br>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;"use openvpn from command line, you need to do SYSTEM "<br>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;"elevation yourself (for example with psexec).");<br>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; break;<br>
+<br>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; case ERROR_ALREADY_INITIALIZED:<br>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; msg(M_NONFATAL, "Adapter %s is already in use", device_guid);<br>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; break;<br>
<br>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; default:<br>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; msg(M_NONFATAL | M_ERRNO, "Failed to register ring buffers");<br>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; }<br>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ret = false;<br>
+&nbsp; &nbsp; &nbsp; &nbsp; }<br>
+<br>
+&nbsp; &nbsp; }<br>
&nbsp; &nbsp; &nbsp;return ret;<br>
&nbsp;}<br></blockquote><div><br></div><div>Looks good and running as SYSTEM works now as expected. Tested on 64 bit Windows 10.</div><div><br></div><div>Acked-by: <a href="mailto:selva.nair@...277...">selva.nair@...277...</a>&nbsp;</div></div></div>
</div></blockquote><blockquote type="cite"><div dir="ltr"></div></blockquote><blockquote type="cite"><div dir="ltr"><span>_______________________________________________</span><br><span>Openvpn-devel mailing list</span><br><span><a href="mailto:Openvpn-devel@lists.sourceforge.net">Openvpn-devel@lists.sourceforge.net</a></span><br><span><a href="https://lists.sourceforge.net/lists/listinfo/openvpn-devel">https://lists.sourceforge.net/lists/listinfo/openvpn-devel</a></span><br></div></blockquote></div></body></html>
--Apple-Mail-9D0E0245-5F2D-4BBB-8E35-22FA072A63AC--

