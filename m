Message-ID: <52663B03.6080809@...1294...>
Date: Tue, 22 Oct 2013 10:44:51 +0200
From: Eike Lohmann <e.lohmann@...1294...>
MIME-Version: 1.0
References: <1346422753-19520-1-git-send-email-arne@...1227...>	<201304110933.r3B9XwPT011987@...1729...>	<20130411105202.GA26778@...1296...>	<5166B459.9020801@...515...>
	<5166C2B1.8050707@...1114...>
	<20130411151131.GX569@...1296...>
In-Reply-To: <20130411151131.GX569@...1296...>
Content-Type: multipart/alternative;
	boundary="------------050608070802070703090906"
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Add the client id (CID) to
 the output of the status command
Reply-To: e.lohmann@...1294...
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------050608070802070703090906
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


Hi,

we are developing a damon wich connects to the management interface from a lokal 
openvpn server.
This daemon authenticate clients and starts some tasks like "set routes, 
firewall etc." in the background.
We do this because we can't use client-connect, it locks the openvpn main 
process for 100-1000ms if you do a lot of stuff there like"SQL query, set 
routes, set firewall, disconnect clients on other machines. etc."

Our problem right now is, if the server ist running we don't know wich CID are 
connected and there is no way to query this from status file or via management 
interface.

In the Changelog of 2.2 and 2.3 is no entry about CID and I want to ask if this 
feature went into the code or not?

Thanks for any help, Eike.

Example:
[1379691142.394271] 64 bytes from 80.146.164.25: icmp_req=21 ttl=61 time=940 ms

[pid 1929] 1379691140.828976 clone(Process 9597 attached
child_stack=0, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD, 
child_tidptr=0x7f8f66c8e9d0) = 9597 <0.192637>
[pid 1929] 1379691141.021980 wait4(9597, Process 1929 suspended
<unfinished ...>
[pid 9597] 1379691141.022386 execve("/etc/openvpn/client-connect.sh", 
["/etc/openvpn/client-connect.sh", "/tmp/openvpn_cc_2863505f0b808f75"...], [/* 
26 vars */]) = 0 <0.021794>

[pid 1929] 1379691142.109748 <... wait4 resumed> [{WIFEXITED(s) && 
WEXITSTATUS(s) == 0}], 0, NULL) = 9597 <1.087736>



Am 11.04.2013 17:11, schrieb Gert Doering:
> Hi,
>
> On Thu, Apr 11, 2013 at 04:03:29PM +0200, David Sommerseth wrote:
>> Rather have a policy ... if a patch breaks something, fix it within
>> 24-48 hours, if not use git-revert.
> works for me.
>
> Usually these are minor issues anyway, like "symbol not available on
> particular platforms" (MIN() comes to mind) or "breaks for a certain
> combination of compile time options", and those can be fixed quickly
> as soon as spotted by buildbot.
>
> gert
>
>
>
>
> ------------------------------------------------------------------------------
> Precog is a next-generation analytics platform capable of advanced
> analytics on semi-structured data. The platform includes APIs for building
> apps and a phenomenal toolset for data science. Developers can use
> our toolset for easy data analysis & visualization. Get a free account!
> http://www2.precog.com/precogplatform/slashdotnewsletter
>
>
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel


--------------050608070802070703090906
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta content="text/html; charset=UTF-8" http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <br>
    Hi,<br>
    <br>
    we are developing a damon wich connects to the management interface
    from a lokal openvpn server.<br>
    This daemon authenticate clients and starts some tasks like "set
    routes, firewall etc." in the background.<br>
    We do this because we can't use client-connect, it locks the openvpn
    main process for 100-1000ms if you do a lot of stuff there like"SQL
    query, set routes, set firewall, disconnect clients on other
    machines. etc." <br>
    <br>
    Our problem right now is, if the server ist running we don't know
    wich CID are connected and there is no way to query this from status
    file or via management interface.<br>
    <br>
    In the Changelog of 2.2 and 2.3 is no entry about CID and I want to
    ask if this feature went into the code or not?<br>
    <br>
    Thanks for any help, Eike.<br>
    <br>
    Example:<br>
    <tt>[1379691142.394271] 64 bytes from 80.146.164.25: icmp_req=21
      ttl=61 time=940 ms</tt><tt><br>
    </tt><tt><br>
    </tt><tt>[pid 1929] 1379691140.828976 clone(Process 9597 attached</tt><tt><br>
    </tt><tt>child_stack=0,
      flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD,
      child_tidptr=0x7f8f66c8e9d0) = 9597 &lt;0.192637&gt;</tt><tt><br>
    </tt><tt>[pid 1929] 1379691141.021980 wait4(9597, Process 1929
      suspended</tt><tt><br>
    </tt><tt> &lt;unfinished ...&gt;</tt><tt><br>
    </tt><tt>[pid 9597] 1379691141.022386
      execve("/etc/openvpn/client-connect.sh",
      ["/etc/openvpn/client-connect.sh",
      "/tmp/openvpn_cc_2863505f0b808f75"...], [/* 26 vars */]) = 0
      &lt;0.021794&gt;</tt><tt><br>
    </tt><tt><br>
    </tt><tt>[pid 1929] 1379691142.109748 &lt;... wait4 resumed&gt;
      [{WIFEXITED(s) &amp;&amp; WEXITSTATUS(s) == 0}], 0, NULL) = 9597
      &lt;1.087736&gt;</tt><br>
    <br>
    <br>
    <br>
    <div class="moz-cite-prefix">Am 11.04.2013 17:11, schrieb Gert
      Doering:<br>
    </div>
    <blockquote cite="mid:20130411151131.GX569@...1296..."
      type="cite">
      <pre wrap="">Hi,

On Thu, Apr 11, 2013 at 04:03:29PM +0200, David Sommerseth wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="">Rather have a policy ... if a patch breaks something, fix it within
24-48 hours, if not use git-revert.
</pre>
      </blockquote>
      <pre wrap="">
works for me.  

Usually these are minor issues anyway, like "symbol not available on
particular platforms" (MIN() comes to mind) or "breaks for a certain
combination of compile time options", and those can be fixed quickly
as soon as spotted by buildbot.

gert


</pre>
      <br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <br>
      <pre wrap="">------------------------------------------------------------------------------
Precog is a next-generation analytics platform capable of advanced
analytics on semi-structured data. The platform includes APIs for building
apps and a phenomenal toolset for data science. Developers can use
our toolset for easy data analysis &amp; visualization. Get a free account!
<a class="moz-txt-link-freetext" href="http://www2.precog.com/precogplatform/slashdotnewsletter">http://www2.precog.com/precogplatform/slashdotnewsletter</a></pre>
      <br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <br>
      <pre wrap="">_______________________________________________
Openvpn-devel mailing list
<a class="moz-txt-link-abbreviated" href="mailto:Openvpn-devel@lists.sourceforge.net">Openvpn-devel@lists.sourceforge.net</a>
<a class="moz-txt-link-freetext" href="https://lists.sourceforge.net/lists/listinfo/openvpn-devel">https://lists.sourceforge.net/lists/listinfo/openvpn-devel</a>
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------050608070802070703090906--

