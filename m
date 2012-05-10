Message-ID: <4FABCDC3.9010205@...1227...>
Date: Thu, 10 May 2012 16:16:35 +0200
From: Arne Schwabe <arne@...1227...>
MIME-Version: 1.0
References: <4FAAE0A1.2080808@...1227...>
	<CAOazyz2wZ3n-70Pk8W_Z3OE_4_4th1PXWUOZUjOjNXetPkxc7g@...278...>
	<4FAAF152.7070508@...1227...>
	<CAOazyz35bB=q1hpdzjj_aHZ7K_0koT8pcw0csham2AOwMqGrfg@...278...>
	<4FAAF945.8070005@...1227...>
	<CAOazyz12Rw0kOSS+siU7tLP4eXO5XkhexjVLn+uC97s4K1Z8EQ@...278...>
	<4FAAFCB4.8040606@...1227...>
	<CAOazyz2wP2ms7HC31LPp3VzFRBu+S3zURZm1ozz0MzjmhQv07g@...278...>
	<4FAB0556.50903@...1227...>
	<CAOazyz2pdJysuaEhoDL8O=S=CdEfW8XCuB6n8YrnKjOBqstTPA@...278...>
	<1CED409804E2164C8104F9E623B08B9012D1CF8A98@...1436...>
	<CAOazyz0Qb8xa-FUqQcMDX=w+=Vb3J8sQ2R8GAxNtfWxT-4DNkw@...278...>
	<1CED409804E2164C8104F9E623B08B9012D1CF8AB9@...1436...>
	<CAOazyz3xObLvBubo4E6vSmepj-8AkGd6P4k-6VXYpvsSm-vs3A@...278...>
	<1CED409804E2164C8104F9E623B08B9012D1CF8AD6@...1436...>
	<4FAB8EEE.8020607@...1114...>
	<1CED409804E2164C8104F9E623B08B9012D1CF8D08@...1436...>
In-Reply-To: <1CED409804E2164C8104F9E623B08B9012D1CF8D08@...1436...>
Content-Type: multipart/alternative;
	boundary="------------080104020303030003000506"
Subject: Re: [Openvpn-devel] [PATCH] Openvpn for Android 4.0 Changeset
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Mendelt Siebenga <mendelt.siebenga@...1435...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------080104020303030003000506
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

I generaly agree with Mendelt. A few additions

> We considered two ways of doing this:
> - Modify OpenVPN to make it possible to use JNI to call into OpenVPN
directly from Java code.

I implemented that in the first version of my app (<=3D 0.4.6). But that
involed evil trickery like set_jmp/long_jmp and had other deficits like
memory leaks when stopping a connection and opening a new one.

> - Modify OpenVPN to add the needed functionality to the management
interface like Arne did.
>
> The first option is probably easier to implement on the Java side but
it requires a lot of changes in the OpenVPN code. The second option
needs a couple of relatively simple changes in OpenVPN and makes it
possible for these changes to be reused in other contexts. Being able to
get routing information and pass TUN devices to OpenVPN might be useful
for some of the GUI projects too.
>
> One thing we did differently is that we don't use JNI at all. We use
the existing build system to cross compile OpenVpn as a normal arm-linux
executable, package it inside the android apk, write it to flash when it
is needed and then execute it from the apk as a separate process. After
this we were planning to use the management interface in the same way
Arne has implemented.

My newest version does also does not use JNI at all :). (aport from a
tiny wrapper around close(int fd) since I have not yet found another way
to close a FileSocket in java).

I build openvpn as library so I only have to write a tiny wrapper to the
flash which calls main of the openvpn library.

> In order to make Arne's changes more reusable I would suggest a couple
of small changes:
>
> - Split the changes up into three features: 1. send socket on the
management interface. 2. Send routing info on management interface 3.
Receive the TUN device on the management interface
>
> - Use command line options or options in the configuration file to
enable these features instead of relying on #ifdef TARGET_ANDROID
>
> - Add some checks to warn about nonsensical settings. For example using
these features without a management interface or with a management
interface on a tcp/ip socket or on an OS that doesn't support sending
filedescriptors over domain sockets should result in an error message.
>
>
> I'm not really sure about putting these changes off into a separate
plugin. I personally like to modularize code as much as possible, but my
guess is that in this case adding the hooks to the plugin interface that
are necessary to allow this functionality to be implemented as a plugin
will add more clutter to OpenVPN than just adding them to the core. I'm
not sure what the plans are for the plugin interface but I can imagine
that if it becomes more powerful over time we might be able to spin off
these changes as a separate plugin later.
>

I agree on these.

--=20
Arne Schwabe, M.Sc. - http://www.uni-paderborn.de/cs/cn/
Computer Science, University of Paderborn, Germany,  +49 5251 60-1756


--------------080104020303030003000506
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta content="text/html; charset=ISO-8859-1"
      http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    I generaly agree with Mendelt. A few additions<br>
    <br>
    <span style="white-space: pre;">&gt; We considered two ways of doing
      this:<br>
      &gt; - Modify OpenVPN to make it possible to use JNI to call into
      OpenVPN directly from Java code.<br>
    </span><br>
    I implemented that in the first version of my app (&lt;= 0.4.6). But
    that involed evil trickery like set_jmp/long_jmp and had other
    deficits like memory leaks when stopping a connection and opening a
    new one.<br>
    <br>
    <span style="white-space: pre;">&gt; - Modify OpenVPN to add the
      needed functionality to the management interface like Arne did.<br>
      &gt;<br>
      &gt; The first option is probably easier to implement on the Java
      side but it requires a lot of changes in the OpenVPN code. The
      second option needs a couple of relatively simple changes in
      OpenVPN and makes it possible for these changes to be reused in
      other contexts. Being able to get routing information and pass TUN
      devices to OpenVPN might be useful for some of the GUI projects
      too.<br>
      &gt;<br>
      &gt; One thing we did differently is that we don't use JNI at all.
      We use the existing build system to cross compile OpenVpn as a
      normal arm-linux executable, package it inside the android apk,
      write it to flash when it is needed and then execute it from the
      apk as a separate process. After this we were planning to use the
      management interface in the same way Arne has implemented.<br>
      <br>
    </span>My newest version does also does not use JNI at all :).
    (aport from a tiny wrapper around close(int fd) since I have not yet
    found another way to close a FileSocket in java). <br>
    <br>
    I build openvpn as library so I only have to write a tiny wrapper to
    the flash which calls main of the openvpn library.<br>
    <br>
    <span style="white-space: pre;">&gt; In order to make Arne's changes
      more reusable I would suggest a couple of small changes:<br>
      &gt;<br>
      &gt; - Split the changes up into three features: 1. send socket on
      the management interface. 2. Send routing info on management
      interface 3. Receive the TUN device on the management interface<br>
      &gt;<br>
      &gt; - Use command line options or options in the configuration
      file to enable these features instead of relying on #ifdef
      TARGET_ANDROID<br>
      &gt;<br>
      &gt; - Add some checks to warn about nonsensical settings. For
      example using these features without a management interface or
      with a management interface on a tcp/ip socket or on an OS that
      doesn't support sending filedescriptors over domain sockets should
      result in an error message.<br>
      &gt;<br>
      &gt;<br>
      &gt; I'm not really sure about putting these changes off into a
      separate plugin. I personally like to modularize code as much as
      possible, but my guess is that in this case adding the hooks to
      the plugin interface that are necessary to allow this
      functionality to be implemented as a plugin will add more clutter
      to OpenVPN than just adding them to the core. I'm not sure what
      the plans are for the plugin interface but I can imagine that if
      it becomes more powerful over time we might be able to spin off
      these changes as a separate plugin later.<br>
      &gt;<br>
    </span><br>
    I agree on these.<br>
    <br>
    -- <br>
    Arne Schwabe, M.Sc. - <a class="moz-txt-link-freetext" href="http://www.uni-paderborn.de/cs/cn/">http://www.uni-paderborn.de/cs/cn/</a><br>
    Computer Science, University of Paderborn, Germany,&nbsp; +49 5251
    60-1756<br>
    <br>
  </body>
</html>

--------------080104020303030003000506--

