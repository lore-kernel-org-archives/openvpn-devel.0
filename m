Message-ID: <53D02C7F.10900@...1147...>
Date: Wed, 23 Jul 2014 23:43:27 +0200
From: Jan Just Keijser <janjust@...1147...>
MIME-Version: 1.0
References: <OF80C424FD.27405071-ONC1257C07.004692C7-C1257C07.004BC7CB@...1923...>	<OFF4D01B5D.C068F160-ONC1257D1D.0055C3F1-C1257D1D.005A2BE1@...1846...>	<9998AE72-2992-4D02-8E27-BE9A55BDBDF6@...1286...>	<20140722193436.GI1118@...1296...>
	<OF0A6F87B6.7643FAD4-ONC1257D1E.00208574-C1257D1E.0022B4AF@...1846...>
In-Reply-To: <OF0A6F87B6.7643FAD4-ONC1257D1E.00208574-C1257D1E.0022B4AF@...1846...>
Content-Type: multipart/alternative;
	boundary="------------010501090005030909080800"
Subject: Re: [Openvpn-devel] Openvpn 2.3.2: "Could not create temporary
 file" ....Too many open files
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: arno.odermatt@...1845..., Gert Doering <gert@...1296...>, Eric Crist <ecrist@...1286...>
Cc: openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------010501090005030909080800
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 23/07/14 08:19, arno.odermatt@...1845... wrote:
> Dear both,
>
> thank you for your reply.
> Yes, we are using the "--client-connect" and according to 2.3 OpenVPN 
> manual (see section below) it does create files by writing to "file 
> named by $1."
>
> Gert, we are sure, there was not a problem with the resources (eg.: 
> max open files, max filed descriptors, etc.) on the system.
> What else can I do about it?
>
try debugging this by adding some statements to the client-connect 
script, e.g.

ls -l /proc/self/fd/* | wc -l >> /tmp/debug.log
sysctl fs.file-nr >> /tmp/debug.log

to find out if there really are no more filehandles available.
For each connection a new client-connect script is started, so I doubt 
that any non-closed file handles will accumulate and cause this problem.

HTH,

JJK
>
> --client-connect script
> Run script on client connection. The script is passed the common name 
> and IP address of the just-authenticated client as environmental 
> variables (see environmental variable section below). The script is 
> also passed the pathname of a not-yet-created temporary file as $1 
> (i.e. the first command line argument), to be used by the script to 
> pass dynamically generated config file directives back to OpenVPN.
> If the script wants to generate a dynamic config file to be applied on 
> the server when the client connects, it should write it to the file 
> named by $1.
>
>
> thank you again
>
> Arno
>
>
>
>
>
>
> From: Gert Doering <gert@...1296...>
> To: Eric Crist <ecrist@...1286...>,
> Cc: arno.odermatt@...1845..., openvpn-devel@lists.sourceforge.net
> Date: 22.07.2014 21:34
> Subject: Re: [Openvpn-devel] Openvpn 2.3.2: "Could not create 
> temporary file" ....Too many open files
> ------------------------------------------------------------------------
>
>
>
> Hi,
>
> On Tue, Jul 22, 2014 at 12:37:19PM -0500, Eric Crist wrote:
> > This isn't an OpenVPN problem, directly.  It appears you have a 
> client connect script, or are storing connection information in temp 
> files.  You can increase the maximum allowed open files in Fedora 
> (you'll have to research that yourself).  Alternatively, stop storing 
> connection data in a temp file for new connections.  OpenVPN, by 
> itself, does not create these temporary files.
>
> Uh, this is not fully correct.  If you use --client-connect (or any of
> the other up scripts that enable passing of config values back), OpenVPN
> will create the temp file to be used for that, to avoid race conditions.
>
> I'm not sure when this was added, but "recentish" (2.2.x)
>
> Now the sema-files do not ring a bell, but we need to check whether we
> properly clean up the other files - but that should be visible in "lsof"
> while OpenVPN is running and after a few connections have completed.
>
> gert


--------------010501090005030909080800
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta content="text/html; charset=ISO-8859-1"
      http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <div class="moz-cite-prefix">Hi,<br>
      <br>
      On 23/07/14 08:19, <a class="moz-txt-link-abbreviated" href="mailto:arno.odermatt@...1845...">arno.odermatt@...1845...</a> wrote:<br>
    </div>
    <blockquote
cite="mid:OF0A6F87B6.7643FAD4-ONC1257D1E.00208574-C1257D1E.0022B4AF@...1846..."
      type="cite"><tt><font size="2">Dear both,</font></tt>
      <br>
      <br>
      <tt><font size="2">thank you for your reply.</font></tt>
      <br>
      <tt><font size="2">Yes, we are using the "--client-connect"
          and according to 2.3 OpenVPN manual (see section below) it
          does create
          files by writing to "</font></tt><font face="sans-serif"
        size="2">file
        named by $1."<br>
        <br>
        Gert, we are sure, there was not a problem with the resources
        (eg.: max
        open files, max filed descriptors, etc.) on the system.</font>
      <br>
      <font face="sans-serif" size="2">What else can I do about it?</font>
      <br>
      <br>
    </blockquote>
    try debugging this by adding some statements to the client-connect
    script, e.g.<br>
    <br>
    ls -l /proc/self/fd/* | wc -l &gt;&gt; /tmp/debug.log<br>
    sysctl fs.file-nr &gt;&gt; /tmp/debug.log<br>
    <br>
    to find out if there really are no more filehandles available.<br>
    For each connection a new client-connect script is started, so I
    doubt that any non-closed file handles will accumulate and cause
    this problem.<br>
    <br>
    HTH,<br>
    <br>
    JJK<br>
    <blockquote
cite="mid:OF0A6F87B6.7643FAD4-ONC1257D1E.00208574-C1257D1E.0022B4AF@...1846..."
      type="cite">
      <br>
      <font face="sans-serif" size="2">--client-connect script</font>
      <br>
      <font face="sans-serif" size="2">Run script on client connection.
        The
        script is passed the common name and IP address of the
        just-authenticated
        client as environmental variables (see environmental variable
        section below).
        The script is also passed the pathname of a not-yet-created
        temporary file
        as $1 (i.e. the first command line argument), to be used by the
        script
        to pass dynamically generated config file directives back to
        OpenVPN.</font>
      <br>
      <font face="sans-serif" size="2">If the script wants to generate a
        dynamic
        config file to be applied on the server when the client
        connects, it should
        write it to the file named by $1.</font>
      <br>
      <br>
      <br>
      <tt><font size="2">thank you again</font></tt>
      <br>
      <br>
      <tt><font size="2">Arno</font></tt>
      <br>
      <font color="#5f5f5f" face="Arial" size="1"><br>
      </font><font color="#008000" face="Arial" size="1"><br>
      </font>
      <br>
      <br>
      <br>
      <br>
      <font color="#5f5f5f" face="sans-serif" size="1">From: &nbsp; &nbsp; &nbsp;
        &nbsp;</font><font face="sans-serif" size="1">Gert Doering
        <a class="moz-txt-link-rfc2396E" href="mailto:gert@...1296...">&lt;gert@...1296...&gt;</a></font>
      <br>
      <font color="#5f5f5f" face="sans-serif" size="1">To: &nbsp; &nbsp; &nbsp;
        &nbsp;</font><font face="sans-serif" size="1">Eric Crist
        <a class="moz-txt-link-rfc2396E" href="mailto:ecrist@...1286...">&lt;ecrist@...1286...&gt;</a>,
      </font>
      <br>
      <font color="#5f5f5f" face="sans-serif" size="1">Cc: &nbsp; &nbsp; &nbsp;
        &nbsp;</font><font face="sans-serif" size="1"><a class="moz-txt-link-abbreviated" href="mailto:arno.odermatt@...1845...">arno.odermatt@...1845...</a>,
        <a class="moz-txt-link-abbreviated" href="mailto:openvpn-devel@lists.sourceforge.net">openvpn-devel@lists.sourceforge.net</a></font>
      <br>
      <font color="#5f5f5f" face="sans-serif" size="1">Date: &nbsp; &nbsp; &nbsp;
        &nbsp;</font><font face="sans-serif" size="1">22.07.2014 21:34</font>
      <br>
      <font color="#5f5f5f" face="sans-serif" size="1">Subject: &nbsp; &nbsp;
        &nbsp; &nbsp;</font><font face="sans-serif" size="1">Re: [Openvpn-devel]
        Openvpn 2.3.2: "Could not create temporary file" ....Too many
        open files</font>
      <br>
      <hr noshade="noshade">
      <br>
      <br>
      <br>
      <tt><font size="2">Hi,<br>
          <br>
          On Tue, Jul 22, 2014 at 12:37:19PM -0500, Eric Crist wrote:<br>
          &gt; This isn't an OpenVPN problem, directly. &nbsp;It appears you
          have
          a client connect script, or are storing connection information
          in temp
          files. &nbsp;You can increase the maximum allowed open files in
          Fedora
          (you'll have to research that yourself). &nbsp;Alternatively, stop
          storing
          connection data in a temp file for new connections. &nbsp;OpenVPN,
          by itself,
          does not create these temporary files.<br>
          <br>
          Uh, this is not fully correct. &nbsp;If you use --client-connect
          (or any
          of<br>
          the other up scripts that enable passing of config values
          back), OpenVPN<br>
          will create the temp file to be used for that, to avoid race
          conditions.<br>
          <br>
          I'm not sure when this was added, but "recentish" (2.2.x)<br>
          <br>
          Now the sema-files do not ring a bell, but we need to check
          whether we<br>
          properly clean up the other files - but that should be visible
          in "lsof"<br>
          while OpenVPN is running and after a few connections have
          completed.<br>
          <br>
          gert</font></tt><br>
    </blockquote>
    <br>
  </body>
</html>

--------------010501090005030909080800--

