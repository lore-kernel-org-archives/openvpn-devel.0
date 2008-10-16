From: Jose Sanchez <jose.informatica@...1125...>
Date: Thu, 16 Oct 2008 12:40:48 +0200
Message-Id: <1224153648.8235.10.camel@...1126...>
Mime-Version: 1.0
Subject: [Openvpn-devel] About using fork inside a plugin
Reply-To: jose.informatica@...1125...
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
To: openvpn-devel@lists.sourceforge.net

Hello, I am doing a plugin that needs to listen at a particular port to
send the events (connections and desconnections) to the connected
clients. This is the main reason because I have used the fork() call but
seems not to work very well:

OPENVPN_EXPORT openvpn_plugin_handle_t
openvpn_plugin_open_v1 (unsigned int *type_mask, const char *argv[],
const char *envp[]) {

  int procid;
  if (pipe(data_pipe) =3D=3D -1) {
    perror("pipe");
    exit(1);
  }

  procid=3Dfork();

  if ((procid) =3D=3D 0) {
     //I am the child (I should execute the listen and create new forks
for the accept() clients)

    int nsocket;

    /* This part is for the socket (must be before registering anything
to prevent double events) */
    struct sockaddr_in serversocket;
    nsocket =3D socket(AF_INET, SOCK_STREAM, 0);
    serversocket.sin_family =3D AF_INET;
    serversocket.sin_port =3D htons(PORT);
    serversocket.sin_addr.s_addr =3D INADDR_ANY;
    serversocket.sin_port =3D htons(PORT);
    serversocket.sin_addr.s_addr =3D INADDR_ANY;
    memset(&(serversocket.sin_zero), 0, 8);
    bind(nsocket, (struct sockaddr *)&serversocket, sizeof(struct
sockaddr));
    listen(nsocket, MAX_WAIT_CLIENTS);


    for(;;){
      /* Once connection is accepted, we send this information to the
pipe for the next event
       * on the next event of the plugin, parent thread will add those
file descriptors connected and
       * will remove sockets giving errors from the notification list.
       */
      struct sockaddr_un remoteconnection;
      //remoteconnection.sin_family=3DAF_INET;
      int sin_size =3D sizeof(struct sockaddr_un);
      //int sin_size=3Dsizeof(remoteconnection);
      int newfd=3Daccept(nsocket, (struct sockaddr *)&remoteconnection,
&sin_size);

      if (newfd !=3D -1) {
        char temp[10];
        sprintf(temp,"Connected");
        send(newfd, temp, strlen(temp), 0);
        write(data_pipe[1], &newfd, 1);
      }
    }

    exit(0);

  } else {
...
here I return the context.
}

questions are: Can I use fork? Is any example of a plugin using fork()?
Where should I use the fork/must execute listen() call?.

What happens is that the client can never finish to connect to the
server and in the middle of the negociation, if I connect to the socket,
the server breaks down (segmentation fault).

Thanks in advance for your help or ideas.


--=20
Jose S=C3=A1nchez <jose.informatica@...1125...>

CGED La Milagrosa
http://www.centrolamilagrosa.org

Grupo de investigaci=C3=B3n en Gerontolog=C3=ADa
http://gerontologia.udc.es


Esta informaci=C3=B3n es privada y confidencial y est=C3=A1 dirigida=20
=C3=BAnicamente a su destinatario. Si usted no es el destinatario=20
original de este mensaje y por este medio pudo acceder a dicha=20
informaci=C3=B3n por favor elimine el mensaje y notifique el env=C3=ADo=20
err=C3=B3neo al remitente. La distribuci=C3=B3n o copia de este mensaje est=
=C3=A1=20
estrictamente prohibida. Esta comunicaci=C3=B3n es s=C3=B3lo para prop=C3=
=B3sitos=20
de informaci=C3=B3n y no deber=C3=ADa ser considerada como una declaraci=C3=
=B3n=20
oficial del CGED La Milagrosa. La transmisi=C3=B3n de e-mails no=20
garantiza que el correo electr=C3=B3nico sea seguro. Por consiguiente,=20
no manifestamos que esta informaci=C3=B3n sea completa o precisa. Toda=20
informaci=C3=B3n est=C3=A1 sujeta a alterarse sin previo aviso. Este Correo=
=20
Electr=C3=B3nico ha sido procesado por nuestro sistema de Antivirus=20
corporativo.

This information is private and confidential and intended for the=20
recipient only. If you are not the intended recipient of this=20
message you are hereby notified that any review it and notify the=20
sender immediately, dissemination, distribution or copying of this=20
message is strictly prohibited. This communication is for=20
information purposes only and should not be regarded as an=20
official statement from CGED La Milagrosa. Email transmission=20
cannot be guaranteed to be secure. Therefore, we do not represent=20
that this information is complete or accurate and it should not be=20
relied upon as such.All information is subject to change without=20
notice. This email has been scanned by our Antivirus system


