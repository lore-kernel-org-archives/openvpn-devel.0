Message-ID: <4348E1EF.8020906@...361...>
From: Rolf Fokkens <r.fokkens@...361...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] Patch: TAP usage made non ARP dependent
References: <43404D99.8080309@...361...>  <434189C7.5090304@...361...>  <1128369731.6952.59.camel@...399...> <4342703F.90607@...361...>  <1128428582.7061.18.camel@...399...>  <4342D092.4050502@...361...>  <1128619301.7000.58.camel@...399...>  <4346A01F.4030106@...361...> <1128702738.7000.97.camel@...399...> <4346ED46.4040204@...361...> <43478832.9050200@...361...> <Pine.LNX.4.58.0510081447170.32321@...41...>
In-Reply-To: <Pine.LNX.4.58.0510081447170.32321@...41...>
Content-Type: multipart/alternative;
 boundary="------------090001070400090705060108"
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Sun Oct  9 02:26:26 2005
To: James Yonan <jim@...41...>
Cc: openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------090001070400090705060108
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

James Yonan wrote:

>Why don't you use the existing multi_context::vhash hash to keep track of
>the server-side MAC table?  I know that this hash is usually used to
>associate MAC or IP addresses with a given client instance, but it seems
>ideally suited for this.  Maybe you could add a flag to struct multi_route
>to indicate that the MAC is server-side and set multi_route::instance to
>NULL.
>  
>
I considered that, but after trying that for an hour I realized that I 
had a hard time getting an accurate overview of the code.  For example: 
there are 24 function definitions in lists.h, what do they all do and 
how do they affect each other?
Two major issues needed to be resolved:

    * A FIFO list through all hash elements to easily remove the oldest
      element.
    * The bucket bases locking can no longer exist if there's a FIFO
      structure through all entries (and buckets).

So I had to consider code at many places, including the locking (for 
multi threading I assume), which requires a lot of testing to make sure 
it all works well.

As I need this functionality quite soon (I expect several hundreds of 
MAC entries behind one of the clients, so there should be no MAC quotum 
for clients), so I decided to create a prototype based on a separate MAC 
table. The coding of the mac_table.[ch] files took me about 2 hours, 
including a stand alone program (without OpenVPN) to test it. As the API 
is small (5 function prototypes in mac_table.h) it was realy easy to 
integrate it into multi.c (another 2 hours, including testing).

Bottomline: I needed a (working) prototype without to much effort, to 
see if this solves the problems I'm experiencing.

Though I'm sure it's possible to integrate the mac_table features in 
lists.c, It would take me a long time to do so, because lists.c has a 
generic structure that is uses in several ways and testing may be hard. 
The mac_table.c file is just over 300 lines and has a simple API (5 
functions in mac_table.h) which made both debugging and testing easy. 
Because MAC tables operate different from route caches you may consider 
different implementations, but of course that's up to you.

>Also, it would be great if you could #ifdef this code so that we can turn 
>it on or off.
>  
>
Sure, I'll do that. I'll do it based on mac_table.[ch], to save time. 
OK? If you want we can integrate mac_table functionality into 
lists.[ch], but it may require a lot of your help.

>James
>  
>

--------------090001070400090705060108
Content-Type: text/html; charset=us-ascii
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
  <title></title>
</head>
<body bgcolor="#ffffff" text="#000000">
James Yonan wrote:
<blockquote cite="midPine.LNX.4.58.0510081447170.32321@...41..."
 type="cite">
  <pre wrap="">Why don't you use the existing multi_context::vhash hash to keep track of
the server-side MAC table?  I know that this hash is usually used to
associate MAC or IP addresses with a given client instance, but it seems
ideally suited for this.  Maybe you could add a flag to struct multi_route
to indicate that the MAC is server-side and set multi_route::instance to
NULL.
  </pre>
</blockquote>
I considered that, but after trying that for an hour I realized that I
had a hard time getting an accurate overview of the code.&nbsp; For example:
there are 24 function definitions in lists.h, what do they all do and
how do they affect each other?<br>
Two major issues needed to be resolved:<br>
<ul>
  <li>A FIFO list through all hash elements to easily remove the oldest
element.<br>
  </li>
  <li>The bucket bases locking can no longer exist if there's a FIFO
structure through all entries (and buckets).</li>
</ul>
So I had to consider code at many places, including the locking (for
multi threading I assume), which requires a lot of testing to make sure
it all works well.<br>
<br>
As I need this functionality quite soon (I expect several hundreds of
MAC entries behind one of the clients, so there should be no MAC quotum
for clients), so I decided to create a prototype based on a separate
MAC table. The coding of the mac_table.[ch] files took me about 2
hours, including a stand alone program (without OpenVPN) to test it. As
the API is small (5 function prototypes in mac_table.h) it was realy
easy to integrate it into multi.c (another 2 hours, including testing).<br>
<br>
Bottomline: I needed a (working) prototype without to much effort, to
see if this solves the problems I'm experiencing.<br>
<br>
Though I'm sure it's possible to integrate the mac_table features in
lists.c, It would take me a long time to do so, because lists.c has a
generic structure that is uses in several ways and testing may be hard.
The mac_table.c file is just over 300 lines and has a simple API (5
functions in mac_table.h) which made both debugging and testing easy.
Because MAC tables operate different from route caches you may consider
different implementations, but of course that's up to you.<br>
<blockquote cite="midPine.LNX.4.58.0510081447170.32321@...41..."
 type="cite">
  <pre wrap="">Also, it would be great if you could #ifdef this code so that we can turn 
it on or off.
  </pre>
</blockquote>
Sure, I'll do that. I'll do it based on mac_table.[ch], to save time.
OK? If you want we can integrate mac_table functionality into
lists.[ch], but it may require a lot of your help.<br>
<blockquote cite="midPine.LNX.4.58.0510081447170.32321@...41..."
 type="cite">
  <pre wrap="">James
  </pre>
</blockquote>
</body>
</html>

--------------090001070400090705060108--

