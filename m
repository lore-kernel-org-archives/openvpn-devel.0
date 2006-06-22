Message-ID: <184379570606220830q3180ebavcc4a6d624c56525a@...278...>
Date: Thu, 22 Jun 2006 18:30:21 +0300
From: "Sameh Attia" <sattia@...277...>
In-Reply-To: <000f01c69605$c093c370$1601a8c0@...576...>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_10924_7742898.1150990221326"
References: <184379570606220445o51075eddt25d051dcb3f8ed28@...278...>
	<000f01c69605$c093c370$1601a8c0@...576...>
Subject: Re: [Openvpn-devel] i-mate SP5 & OpenVPN
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: openvpn-devel@lists.sourceforge.net

------=_Part_10924_7742898.1150990221326
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Thank you Dave for your fast response, I did not expect to get any reply
today.
Are there any pointers I can start with?

On 6/22/06, Dave <dev@...575...> wrote:
>
>  It's fairly different in a couple areas:
>
> *  The installer needs to be marked in some way as supporting smartphone.
> This is the problem you are having now.
> *  Smartphone devices don't have all the runtime functionality the
> PocketPC devices do.  Even if you manually installed it you would still have
> missing dependencies.
> *  Smartphone GUI is a little different that PocketPC in that it does not
> use touchscreen, etc.  The GUI will need to be reworked a little to make is
> useable in the Smartphone context.
> *  Smartphone devices occaisionally require execution privileges that will
> preclude running software not signed by a special 'privileged' code signing
> key from the Mobile Operator.  Enforcing this is at the operator's
> descretion, so it depends on who you have.
>
> Several folks have asked about Smartphone as of late, and there is
> some exploratory work going on.  The first items listed above are doable.
> The last one is more questionable.  There is also the possibility that you
> can unlock your device even if it is locked down if you find yourself in
> that situation.
>
> So, short story is there is not Smartphone support, but you may wish to
> check back in about a month or so.
>
>  -----Original Message-----
> *From:* openvpn-devel-bounces@lists.sourceforge.net [mailto:
> openvpn-devel-bounces@lists.sourceforge.net] *On Behalf Of *Sameh Attia
> *Sent:* Thursday, June 22, 2006 6:46 AM
> *To:* openvpn-devel@lists.sourceforge.net
> *Subject:* [Openvpn-devel] i-mate SP5 & OpenVPN
>
> Hi,
>    I bought this phone http://www.imate.com/t-DETAILS_SP5.aspx after
> checking your site to make sure it is supported. Unfortunately, when I
> attempted to install the client I got the error message of something like
> 'unsuccessfull installation ....unsupported device'.
>
> I checked the forum to see if there are any workarounds but no avail. Is
> the Windows Mobile 5.0 Smart Phone Edition different from the Windows
> Mobile 5.0?
> Please help.
> Regards
>
>
>


-- 
Sameh Attia
Information Security Manager
Red Hat Certified Engineer
TE Data
--
The two basic principles of Windows system administration:

   * For minor problems, reboot
   * For major problems, reinstall

dc -e
'603178305900664311156641389051003470569569613466992253686426210705237258P'

------=_Part_10924_7742898.1150990221326
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Thank you Dave for your fast response, I did not expect to get any reply today.<br>Are there any pointers I can start with?<br><br><div><span class="gmail_quote">On 6/22/06, <b class="gmail_sendername">Dave</b> &lt;<a href="mailto:dev@...575...">
dev@...575...</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><div>





<div>
<div><span><font color="#0000ff" face="Courier New" size="2">It's&nbsp;fairly different in&nbsp;a 
couple&nbsp;areas:</font></span></div>
<div><span><font color="#0000ff" face="Courier New" size="2"></font></span>&nbsp;</div>
<div><span><font color="#0000ff" face="Courier New" size="2">*&nbsp; The installer needs to be marked in some way as supporting 
smartphone.&nbsp; This is the problem you are having now.</font></span></div>
<div><span><font color="#0000ff" face="Courier New" size="2">*&nbsp; Smartphone devices don't have all the runtime functionality the 
PocketPC devices do.&nbsp; Even if you manually installed it you would still 
have missing dependencies.</font></span></div>
<div><span><font color="#0000ff" face="Courier New" size="2">*&nbsp; Smartphone GUI is a little different that PocketPC in that it 
does not use touchscreen, etc.&nbsp; The GUI will need to be reworked a little 
to make is useable in the Smartphone context.</font></span></div>
<div><span><font color="#0000ff" face="Courier New" size="2">*&nbsp; Smartphone devices&nbsp;occaisionally require execution 
privileges that will preclude running software not signed by a special 
'privileged' code signing key from the Mobile Operator.&nbsp; Enforcing this is 
at the operator's descretion, so it depends on who you have.</font></span></div>
<div><span><font color="#0000ff" face="Courier New" size="2"></font></span>&nbsp;</div>
<div><span><font color="#0000ff" face="Courier New" size="2">Several folks have asked about Smartphone as of late, and there is 
some&nbsp;exploratory work going on.&nbsp; The first items listed above are 
doable.&nbsp; The last one is more questionable.&nbsp; There is also the 
possibility that you can unlock your device even if it is locked down if you 
find yourself in that situation.</font></span></div>
<div><span><font color="#0000ff" face="Courier New" size="2"></font></span>&nbsp;</div>
<div><span><font color="#0000ff" face="Courier New" size="2">So, short story is there is not Smartphone support, but you may wish to 
check back in about a month or so.</font></span></div>
<blockquote style="border-left: 2px solid rgb(0, 0, 255); padding-left: 5px; margin-left: 5px; margin-right: 0px;">
  <div></div>
  <div dir="ltr" align="left" lang="en-us"><font face="Tahoma" size="2">-----Original Message-----<br><b>From:</b> 
  <a href="mailto:openvpn-devel-bounces@lists.sourceforge.net" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">openvpn-devel-bounces@lists.sourceforge.net</a> 
  [mailto:<a href="mailto:openvpn-devel-bounces@lists.sourceforge.net" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">openvpn-devel-bounces@lists.sourceforge.net</a>] <b>On Behalf Of </b>Sameh 
  Attia<br><b>Sent:</b> Thursday, June 22, 2006 6:46 AM<br><b>To:</b> 
  <a href="mailto:openvpn-devel@lists.sourceforge.net" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">openvpn-devel@lists.sourceforge.net</a><br><b>Subject:</b> [Openvpn-devel] i-mate 
  SP5 &amp; OpenVPN<br><br></font></div>Hi,<br>&nbsp;&nbsp; I bought this phone 
  <a href="http://www.imate.com/t-DETAILS_SP5.aspx" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">http://www.imate.com/t-DETAILS_SP5.aspx</a> 
  after checking your site to make sure it is supported. Unfortunately, when I 
  attempted to install the client I got the error message of something like 
  'unsuccessfull installation ....unsupported device'. <br><br>I checked the 
  forum to see if there are any workarounds but no avail. Is the Windows Mobile 
  5.0 Smart Phone Edition different from the Windows Mobile 5.0?<br>Please 
  help.<br>Regards<br></blockquote></div>

</div><br clear="all"></blockquote></div><br><br clear="all"><br>-- <br>Sameh Attia<br>Information Security Manager<br>Red Hat Certified Engineer<br>TE Data<br>--<br>The two basic principles of Windows system administration:
<br><br>&nbsp;&nbsp; * For minor problems, reboot<br>&nbsp;&nbsp; * For major problems, reinstall<br><br>dc -e '603178305900664311156641389051003470569569613466992253686426210705237258P'

------=_Part_10924_7742898.1150990221326--

