MIME-Version: 1.0
In-Reply-To: <5367801D.5060904@...1114...>
References: <CALufPjXL2hX-W25uBvGNk1M_TbbrkZcUMe-3dYwD2oa9f6DD2Q@...278...>
	<5367801D.5060904@...1114...>
Date: Tue, 6 May 2014 08:03:49 +0200
Message-ID: <CALufPjUyvkuO-LCeVcGwHRL0PBMyMvCRM4ZB2m+oS_UngjaCyA@...278...>
From: Marine B <yunai39@...277...>
Content-Type: multipart/alternative; boundary=047d7bfcf9c2ff7bd004f8b50291
Subject: Re: [Openvpn-devel] [New Plugin] Diifferent subnet for different
 Group of user
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--047d7bfcf9c2ff7bd004f8b50291
Content-Type: text/plain; charset=UTF-8

Thanks for you answers,

As you said we would like to use those different subnet to give different
firewall rules.


I just a rapid look at the link you gave me. Why did I need this plugin is
because I dont want to have to setup theconfig file off each client before
hand. I could use the link you gave me, but to had a new group You will
need to edit the client connect script, an same I do not want other people
to edit it. While I'm fine with them editing just the config file.

Where I work, I created two OpenVPN server, and out Help Desk Team is
always adding new user to the VPN, and I do not want them to be allowded to
edit my server.

I'm still working on the plugin as there is still a lot to do, but I really
like the idea of using the organization unit to define the different subnet.


2014-05-05 14:12 GMT+02:00 David Sommerseth <openvpn.list@...1114...>:

> On 05/05/14 08:02, Marine B wrote:
> > Good Morning,
> >
> > I have made an atempte at creating a new plugin for OpenVPN. My goal was
> > to be able to give ip, comming from different subnet , to user from
> > different group. Let me explain:
> >
> > You have two group:
> > Group A, where user common name follow the regex ^A* and those people
> > need to have an ip in 10.0.0.0/24 <http://10.0.0.0/24>
> > Group B, where user common name follow the regex ^B* and those people
> > need to have an ip in 10.0.1.0/24 <http://10.0.1.0/24>
>
> Can you please explain why it's important that these groups have
> different IP subnets?
>
> Because, if it's due to access control and firewalling your VPN clients
> (the most common argument for doing this), a dynamic firewall is far
> better suitable, IMO.  One approach is to use the built-in packet
> filter.  It's not too easy to work with, but here's a pretty good walk
> through of it:
> <http://backreference.org/2010/06/18/openvpns-built-in-packet-filter/>
> ... Another approach which is much more Linux centric can be found here:
> <http://www.eurephia.net/>
>
> I can see that having your users grouped is nice feature.  But I think
> that should be implemented in a different layer.  Perhaps make use of
> X.509 certificate fields (like OU/Organizational Unit).  Having a group
> variable being passed to plug-ins/script hooks.
>
> But it all depends on why you need different sub-nets for your user groups.
>
>
> --
> kind regards,
>
> David Sommerseth
>
>

--047d7bfcf9c2ff7bd004f8b50291
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div>Thanks for you answers, <br><br></div><div>=
As you said we would like to use those different subnet to give different f=
irewall rules.<br><br></div><div><br></div>I just a rapid look at the link =
you gave me. Why did I need this plugin is because I dont want to have to s=
etup theconfig file off each client before hand. I could use the link you g=
ave me, but to had a new group You will need to edit the client connect scr=
ipt, an same I do not want other people to edit it. While I&#39;m fine with=
 them editing just the config file.<br>
<br></div>Where I work, I created two OpenVPN server, and out Help Desk Tea=
m is always adding new user to the VPN, and I do not want them to be allowd=
ed to edit my server.<br><br></div><div>I&#39;m still working on the plugin=
 as there is still a lot to do, but I really like the idea of using the org=
anization unit to define the different subnet.<br>
</div></div><div class=3D"gmail_extra"><br><br><div class=3D"gmail_quote">2=
014-05-05 14:12 GMT+02:00 David Sommerseth <span dir=3D"ltr">&lt;<a href=3D=
"mailto:openvpn.list@...1114..." target=3D"_blank">openvpn.list@...1114...<=
/a>&gt;</span>:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div class=3D"">On 05/05/14 08:02, Marine B =
wrote:<br>
&gt; Good Morning,<br>
&gt;<br>
&gt; I have made an atempte at creating a new plugin for OpenVPN. My goal w=
as<br>
&gt; to be able to give ip, comming from different subnet , to user from<br>
&gt; different group. Let me explain:<br>
&gt;<br>
&gt; You have two group:<br>
&gt; Group A, where user common name follow the regex ^A* and those people<=
br>
</div>&gt; need to have an ip in <a href=3D"http://10.0.0.0/24" target=3D"_=
blank">10.0.0.0/24</a> &lt;<a href=3D"http://10.0.0.0/24" target=3D"_blank"=
>http://10.0.0.0/24</a>&gt;<br>
<div class=3D"">&gt; Group B, where user common name follow the regex ^B* a=
nd those people<br>
</div>&gt; need to have an ip in <a href=3D"http://10.0.1.0/24" target=3D"_=
blank">10.0.1.0/24</a> &lt;<a href=3D"http://10.0.1.0/24" target=3D"_blank"=
>http://10.0.1.0/24</a>&gt;<br>
<br>
Can you please explain why it&#39;s important that these groups have<br>
different IP subnets?<br>
<br>
Because, if it&#39;s due to access control and firewalling your VPN clients=
<br>
(the most common argument for doing this), a dynamic firewall is far<br>
better suitable, IMO. =C2=A0One approach is to use the built-in packet<br>
filter. =C2=A0It&#39;s not too easy to work with, but here&#39;s a pretty g=
ood walk<br>
through of it:<br>
&lt;<a href=3D"http://backreference.org/2010/06/18/openvpns-built-in-packet=
-filter/" target=3D"_blank">http://backreference.org/2010/06/18/openvpns-bu=
ilt-in-packet-filter/</a>&gt;<br>
... Another approach which is much more Linux centric can be found here:<br>
&lt;<a href=3D"http://www.eurephia.net/" target=3D"_blank">http://www.eurep=
hia.net/</a>&gt;<br>
<br>
I can see that having your users grouped is nice feature. =C2=A0But I think=
<br>
that should be implemented in a different layer. =C2=A0Perhaps make use of<=
br>
X.509 certificate fields (like OU/Organizational Unit). =C2=A0Having a grou=
p<br>
variable being passed to plug-ins/script hooks.<br>
<br>
But it all depends on why you need different sub-nets for your user groups.=
<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
<br>
--<br>
kind regards,<br>
<br>
David Sommerseth<br>
<br>
</font></span></blockquote></div><br></div>

--047d7bfcf9c2ff7bd004f8b50291--

